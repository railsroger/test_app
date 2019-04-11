if (typeof RedactorPlugins === 'undefined') var RedactorPlugins = {};

RedactorPlugins.gallery = {

  /** @var object Настройки галереии */
  galleryOptions: {
    max: 15, // максимальное количество изображений в галереи
    tag: 'gallery',
    tagArg: 'urls',
    urlSeparator: '|',
    maxFileSize: 10000000 // 10MB
  },

  /** @var object Фразы используемые в UI */
  galleryTexts: {
    title: 'Gallery',
    images: 'Images'
    // more look in a css file
  },

  /**
   * Возвращает html код редактора галлереи.
   *
   * @param Element targetEl Редактируемый элемент галереи.
   * @return string
   */
  galleryGetModalWindowTemplate: function(targetEl) {
    return '\
      <section class="galleryPluginModalBody">\
        <div>'+this.galleryTexts.images+' (<span class="galleryPluginCounter">0</span>/'+this.galleryOptions.max+')</div>\
        <div class="galleryPluginDropArea">\
          <div class="galleryPluginDropBox"></div>\
        </div>\
        <div>'+this.opts.curLang.or_choose+'</div>\
        <form enctype="multipart/form-data" action="'+this.opts.imageUpload+'" method="post">\
          <input type="file" name="file" multiple="multiple" autocomplete="off"/>\
        </form>\
      </section>\
      <footer class="galleryPluginModalFooter">\
        '+(targetEl?'<button class="redactor_modal_btn redactor_modal_delete_btn">'+this.opts.curLang._delete+'</button>':'')+
        '<button class="redactor_modal_btn redactor_btn_modal_close">'+this.opts.curLang.cancel+'</button>'+
        '<button class="redactor_modal_btn redactor_modal_action_btn">'+this.opts.curLang.save+'</button>\
      </footer>\
    ';
  },

  /**
   * Инициализация плагина.
   */
	init: function() {
    // override setEditor
    this.gallerySetEditorOriginal = this.setEditor;
    this.setEditor = this.gallerySetEditorOverridden;

    // override callback
    this.galleryCallbackOriginal = this.callback;
    this.callback = this.galleryCallbackOverridden;

    // override setNonEditable
    this.gallerySetNonEditableOriginal = this.setNonEditable;
    this.setNonEditable = this.gallerySetNonEditableOverridden;

    // override modalClose
    this.galleryModalCloseOriginal = this.modalClose;
    this.modalClose = this.galleryModalCloseOverridden;

    // use overridden setEditor for init data
    this.set(this.get());

    // tullbar button
    var self = this;
		this.buttonAddAfter('image', 'gallery', this.galleryTexts.title, function() {
      self.galleryShowModal();
		});
	},


  // MODAL WINDOW --------------------------------------------------------------

  /**
   * Показать всплывающее окно с редактором галереи.
   *
   * @param Element targetEl Редактируемый элемент галереи.
   */
  galleryShowModal: function(targetEl) {
    var self = this;
    this.modalInit(this.galleryTexts.title, this.galleryGetModalWindowTemplate(targetEl), 500, function() {
      self.galleryAfterShowModal(targetEl);
    });
  },

  /**
   * Выполняется сразу после отображения редактора галереи.
   *
   * @param Element targetEl Редактируемый элемент галереи.
   */
  galleryAfterShowModal: function(targetEl) {
    var self = this;
    var modalEl = $('#redactor_modal');
    var formEl = modalEl.find('form');

    // save cursor position
    this.selectionSave();

    // urls
    var urlsValue = targetEl? targetEl.attr(this.galleryOptions.tagArg): '';
    this.galleryCreateModalDropBox(urlsValue);

    // bind file drag and drop
    var dropEl = modalEl.find('.galleryPluginDropArea');
    dropEl.bind('dragover', function(e){
      dropEl.addClass('galleryPluginDropAreaHover');
      return false;
    });
    dropEl.bind('dragleave', function(e){
      dropEl.removeClass('galleryPluginDropAreaHover');
      return false;
    });
    dropEl[0].ondrop = function(e){
      e.stopPropagation();
      e.preventDefault();
      dropEl.removeClass('galleryPluginDropAreaHover');
      dropEl.addClass('galleryPluginDropAreaDrop');

      var files = e.dataTransfer.files;
      self.galleryUpload(files, function(urls){
        dropEl.removeClass('galleryPluginDropAreaDrop');
        self.galleryAddModalDropItems(urls);
      });
    };

    // bind file button
    var fileEl = formEl.find('input[name=file]');
    fileEl.bind('change', function(){
      fileEl.attr('disabled', 'disabled');
      self.galleryUpload(fileEl[0].files, function(urls){
        fileEl.removeAttr('disabled');
        formEl[0].reset();
  
        self.galleryAddModalDropItems(urls);
      });
    });

    // bind save button event
    modalEl.find('.redactor_modal_action_btn').click(function() {
      self.gallerySaveButtonClick(targetEl);
      return false;
    });

    // bind delete button event
    modalEl.find('.redactor_modal_delete_btn').click(function() {
      self.galleryDeleteButtonClick(targetEl);
      return false;
    });
  },


  // MODAL LIST ----------------------------------------------------------------

  /**
   * Согдаёт область для drag&drop файлов.
   *
   * @param string urlsValue Набор url через разделитель.
   */
  galleryCreateModalDropBox: function(urlsValue) {
    var modalEl = $('#redactor_modal');
    var dropBoxEl = modalEl.find('.galleryPluginDropBox');
    dropBoxEl.empty();

    // placeholder
    dropBoxEl.html('<div class="galleryPluginDropPlaceholder">'+this.opts.curLang.drop_file_here+'</div>');

    // list
    var listEl = $('<ul class="galleryPluginDropList"></ul>')
    dropBoxEl.append(listEl);

    // items
    var urls = urlsValue? urlsValue.split('|'): [];
    urls = urls.slice(0, this.galleryOptions.max);
    for (var i=0; i<urls.length; i++) {
      var itemEl_ = this.galleryCreateModalDropItem(urls[i]);
      listEl.append(itemEl_);
    }

    // clear
    var clearEl = $('<div class="galleryPluginDropItemClear"></div>')
    dropBoxEl.append(clearEl);

    // sortable
    this.galleryListCreateSortable();

    this.galleryUpdateModalDropBox();
  },

  /**
   * Обновляет состояние области для drag&drop.
   */
  galleryUpdateModalDropBox: function() {
    var modalEl = $('#redactor_modal');
    var placeholderEl = modalEl.find('.galleryPluginDropPlaceholder');
    var listEl = modalEl.find('.galleryPluginDropList');

    // items
    var itemEls = listEl.find('.galleryPluginDropItem');

    // placeholder
    if (itemEls.length) {
      placeholderEl[0].style.display = 'none';
      listEl[0].style.display = '';
    }
    else {
      listEl[0].style.display = 'none';
      placeholderEl[0].style.display = '';
    }

    // counter
    modalEl.find('.galleryPluginCounter').text(itemEls.length);

    // file
    var fileEl = modalEl.find('input[name=file]');
    if (itemEls.length == this.galleryOptions.max) {
      fileEl.attr('disabled', 'disabled');
    }
    else {
      fileEl.removeAttr('disabled');
    }
  },

  /**
   * Добавляет возможность сортировать файлы череp drag&drop.
   */
  galleryListCreateSortable: function() {
    var modalEl = $('#redactor_modal');
    var listEl = modalEl.find('.galleryPluginDropList');
    var dropAreaEl = modalEl.find('.galleryPluginDropArea');

    listEl.sortable({ containment: dropAreaEl });
    listEl.disableSelection();
  },
  /**
   * Убирает возможность сортировать файлы череp drag&drop.
   */
  galleryListDestroySortable: function() {
    var modalEl = $('#redactor_modal');
    var listEl = modalEl.find('.galleryPluginDropList');

    listEl.sortable('destroy');
  },


  // MODAL LIST ITEM -----------------------------------------------------------

  /**
   * Создает html-элемент обного изобращения в редакторе галереи.
   *
   * @param string url
   * @return Element
   */
  galleryCreateModalDropItem: function(url) {
    var imageItemSize = 79;

    // item
    var itemEl = $('<li class="galleryPluginDropItem ui-state-default"></li>')

    // img
    var imgEl = $('<img class="galleryPluginDropItemImg" width="'+imageItemSize+'" height="'+imageItemSize+'"/>');
    imgEl.attr('src', url);
    itemEl.append(imgEl);

    // пропорциональные картинки
    this.galleryGetImageSize(url, function(width, height) {
      if (width == height) {
        return;
      }

      if (width > height) {
        // width
        var proWidth = Math.floor(imageItemSize * width/height);
        imgEl[0].width = proWidth;
        // marginLeft
        var marginLeft = -Math.round((proWidth-imageItemSize)/2);
        imgEl.css('marginLeft', marginLeft);
      }
      else {
        // height
        var proHeight = Math.floor(imageItemSize * height/width);
        imgEl[0].height = proHeight;
        // marginTop
        var marginTop = -Math.round((proHeight-imageItemSize)/2);
        imgEl.css('marginTop', marginTop);
      }
    });

    // delete button
    var deleteEl = $('<div class="galleryPluginButton galleryPluginDeleteButton"></div>');
    itemEl.append(deleteEl);

    var self = this;
    deleteEl.bind('click', function(){
      self.galleryDeleteModalDropItem(itemEl);
    });

    // open button
    var openEl = $('<a href="#" target="_blank"><div class="galleryPluginButton galleryPluginOpenButton"></div></a>');
    openEl.attr('href', url);
    itemEl.append(openEl);

    return itemEl;
  },

  /**
   * Добавляет в набор изображений в редакторе дополнительные элементы.
   *
   * @param array urls
   */
  galleryAddModalDropItems: function(urls) {
    if (!urls || urls.length==0) {
      return;
    }

    var modalEl = $('#redactor_modal');
    var listEl = modalEl.find('.galleryPluginDropList');
    var itemEls = listEl.find('.galleryPluginDropItem');

    // slice
    urls = urls.slice(0, this.galleryOptions.max-itemEls.length);

    this.galleryListDestroySortable();
    for (var i=0; i<urls.length; i++) {
      var itemEl = this.galleryCreateModalDropItem(urls[i]);
      listEl.append(itemEl);
    }
    this.galleryListCreateSortable();

    this.galleryUpdateModalDropBox();
  },

  /**
   * Удаляет элемент из набора изображений в редакторе галереи.
   *
   * @param Element itemEl
   */
  galleryDeleteModalDropItem: function(itemEl) {
    this.galleryListDestroySortable();
    itemEl.remove();
    this.galleryListCreateSortable();

    this.galleryUpdateModalDropBox();
  },


  // MODAL ACTIONS -------------------------------------------------------------

  /**
   * Выполняется при нажатии на кнопку Save.
   *
   * @param Element targetEl Редактируемый элемент галереи.
   */
  gallerySaveButtonClick: function(targetEl) {
    var modalEl = $('#redactor_modal');

    // urls
    var urls = [];
    var imgEls = modalEl.find('.galleryPluginDropList .galleryPluginDropItemImg');
    for (var i=0; i<imgEls.length; i++) {
      var url_ = imgEls[i].src;
      urls.push(url_);
    }

    // insert
		this.selectionRestore();
    if (targetEl) {
      var urlsValue = urls.join(this.galleryOptions.urlSeparator);
      targetEl.attr(this.galleryOptions.tagArg, urlsValue);
    }
    else {
      var sourceHtml = this.galleryCreateTagHtml(urls);
      var editorHtml = this.gallerySourceHtmlToEditorHtml(sourceHtml);
      this.insertHtml(editorHtml);
    }
    this.sync();

    // close
    this.modalClose();
    this.galleryObserve();
  },

  /**
   * Выполняется при нажатии на кнопку Delete.
   *
   * @param Element targetEl Редактируемый элемент галереи.
   */
  galleryDeleteButtonClick: function(targetEl) {
		this.selectionRestore();

    if (targetEl) {
      targetEl.remove();
    }
    this.sync();

    this.modalClose();
  },

  /**
   * Создание тега галереи.
   *
   * @param array urls
   * @return string
   */
  galleryCreateTagHtml: function(urls) {
    var urlsStr = urls.join(this.galleryOptions.urlSeparator);
    var tag = this.galleryOptions.tag;
    var arg = this.galleryOptions.tagArg;
    var html = '<'+tag+' '+arg+'="'+urlsStr+'"></'+tag+'>';
    return html;
  },


  // UPLOAD --------------------------------------------------------------------

  /**
   * Загрузка файлов на сервер.
   *
   * @param array files Массив объектов класса File.
   * @param function callback Функция, которая будет выполнена после загрузки всех файлов.
   *   В функцию будет передан массив url загруженных файлов.
   */
  galleryUpload: function(files, callback) {
    if (!callback) {
      callback = function() {};
    }

    var urls = [];

    var wasSend = false;
    var counter = 0;
    for (var i=0; i<files.length; i++) {
      if (!files[i].type.match(/image.*/) || files[i].size > this.galleryOptions.maxFileSize) {
        continue;
      }

      // data
      var data = new FormData();
      data.append('file', files[i]);

      counter++;
      wasSend = true;

      // send
      $.ajax({
        url: this.opts.imageUpload,
        data: data,
        type: 'post',
        contentType: false,
        processData: false,
        cache: false,
        dataType: 'json',
        // events
        success: function(data) {
          if (data && data.filelink) {
            urls.push(data.filelink);
          }
        },
        complete: function() {
          counter--;
          if (counter==0) {
            callback(urls);
          }
        }
      });
    }

    if (!wasSend) {
      callback();
    }
  },


  // OVERRIDING ----------------------------------------------------------------

  /**
   * To editor gallery overriding.
   */
  gallerySetEditorOverridden: function(html, strip) {
    html = this.gallerySourceHtmlToEditorHtml(html);
    return this.gallerySetEditorOriginal(html, strip);
  },
  gallerySetEditorOriginal: null,

  /**
   * From editor gallery overriding.
   */
  galleryCallbackOverridden: function(type, event, data) {
    if (type == 'syncBefore' && data) {
      data = this.galleryEditorHtmlToSourceHtml(data);
    }
    return this.galleryCallbackOriginal(type, event, data);
  },
  galleryCallbackOriginal: null,

  /**
   * setNonEditable overriding.
   */
  gallerySetNonEditableOverridden: function () {
    this.galleryObserve();
    return this.gallerySetNonEditableOriginal.apply(this, arguments);
  },
  gallerySetNonEditableOriginal: null,

  /**
   * modalClose overriding.
   */
  galleryModalCloseOverridden: function () {
    this.modalSaveBodyOveflow = 'visible';
    return this.galleryModalCloseOriginal.apply(this, arguments);
  },
  galleryModalCloseOriginal: null,


  // OBSERVE -------------------------------------------------------------------

  /**
   * Обслуживание всех галерей в редакторе.
   */
  galleryObserve: function() {
    var galleryEls = this.$editor.find(this.galleryOptions.tag + '.imperaviRedactorGalleryPluginEditorElement');
    for (var i=0; i<galleryEls.length; i++) {
      this.galleryObserveItem(galleryEls[i]);
    }
    this.sync();
  },

  /**
   * Обслуживание одного html элемента галереи в редакторе.
   *
   * @param Element el Элемент галереи в редакторе.
   */
  galleryObserveItem: function(el) {
    el = $(el);

    var urlsValue = el.attr(this.galleryOptions.tagArg);
    if (!urlsValue) {
      el.remove();
      return;
    }

    el.empty();

    // editable
    el.attr("contenteditable", false);

    el.attr('title', this.galleryTexts.title);

    // click
    var self = this;
    el.unbind('click');
    el.bind('click', function(){
      var targetEl = $(this);
			self.galleryShowModal(targetEl);
    });

    // image
    var urls = urlsValue.split(this.galleryOptions.urlSeparator);
    var firstUrl = urls[0];
    el.css({backgroundImage: 'url("'+firstUrl+'")'});

    // image height
    var urlsStr = el.attr(this.galleryOptions.tagArg);
    if (urlsStr) {
      var urls = urlsStr.split(this.galleryOptions.urlSeparator);
      var firstUrl = urls[0];
      this.galleryGetImageSize(firstUrl, function(width, height){
        el.css({height: (5 + height + 5) + 'px'});
      })
    }
  },

  /**
   * Обработка содержимого при переносе из редатора в текст.
   *
   * @param string editorHtml
   * @return string
   */
  galleryEditorHtmlToSourceHtml: function(editorHtml) {
    var containerEl = $('<div>'+editorHtml+'</div>');

    var galleryEls = containerEl.find(this.galleryOptions.tag);
    if (galleryEls.length==0) {
      return editorHtml;
    }
    for (var i=0; i<galleryEls.length; i++) {
      // clear content
      var el_ = $(galleryEls[i]);
      el_.empty();

      // clear attributes
      var attrs_ = this.galleryGetAttrs(galleryEls[i]);
      for (var a=0; a<attrs_.length; a++) {
        if (attrs_[a] != this.galleryOptions.tagArg) {
          el_.removeAttr(attrs_[a]);
        }
      }
    }

    return containerEl.html();
  },

  /**
   * Обработка содержимого при переносе из текста в редатор.
   *
   * @param string sourceHtml
   * @return string
   */
  gallerySourceHtmlToEditorHtml: function(sourceHtml) {
    var containerEl = $('<div>'+sourceHtml+'</div>');

    var galleryEls = containerEl.find(this.galleryOptions.tag);
    if (galleryEls.length==0) {
      return sourceHtml;
    }

    for (var i=0; i<galleryEls.length; i++) {
      var el_ = $(galleryEls[i]);
      el_.addClass('imperaviRedactorGalleryPluginEditorElement');
    }

    return containerEl.html();
  },


  // SERVICES ------------------------------------------------------------------

  /**
   * Получить массив имён всех атрибутов элемента.
   *
   * @param Element el
   * @return array
   */
  galleryGetAttrs: function(el) {
    var out = [];

    var attrs = el.attributes;
    for (var i=0; i<attrs.length; i++){
      out.push(attrs.item(i).nodeName);
    }

    return out;
  },

  /**
   * Позволяет получить размеры изображение (px).
   *
   * @param string url Адресс изображения.
   * @param function callback(width, height) Функция, в которую будут переданы размеры изображения.
   */
  galleryGetImageSize: function(url, callback) {
    if (this.galleryGetImageSizeCache[url]) {
      callback(this.galleryGetImageSizeCache[url].width, this.galleryGetImageSizeCache[url].height);
      return;
    }

    // container
    var containerEl = $('#imperaviRedactorGalleryPluginModalImagePoligon');
    if (containerEl.length == 0) {
      var html = '<div id="imperaviRedactorGalleryPluginModalImagePoligon" style="overflow:hidden;height:0;width:0;opacity:0;"></div>';
      var containerEl = $(html);
      $('body').append(containerEl);
    }

    // image
    var imgEl = $('<img/>');
    var self = this;
    imgEl.bind('load', function() {
      callback(this.width, this.height);
      self.galleryGetImageSizeCache[url] = {width:this.width, height:this.height};
      $(this).remove();
    });

    containerEl.append(imgEl);
    imgEl.attr('src', url);
  },

  /** @var object Кэш для galleryGetImageSize. */
  galleryGetImageSizeCache: {}

}