module ApplicationHelper
  def gallery_html(images_urls)
    slider_id = 'gallery' + Random.rand(1...999).to_s
    images = images_urls.split('|').map do |url|
      /http[s]?:\/\/.+\/spree\/products\/\d+\/slider_small\/(?<image_url>.+)/ =~ url
      image = Spree::Image.find_by(attachment_file_name: CGI.unescape(image_url))

      '<div class="simple-slider__slide swiper-slide">' \
      '  <img class="simple-slider__image" data-gallery="' + slider_id + '" data-src="' + image.attachment.url(:slider_large) + '" src="' + image.attachment.url(:slider_small) + '" />' \
      '</div>'
    end

    # raise images


    navigation = if images.count > 1
                   '  <div class="simple-slider__pagination swiper-pagination"></div>' \
                   '  <button class="simple-slider__navigation simple-slider__navigation_left" type="button"></button>' \
                   '  <button class="simple-slider__navigation simple-slider__navigation_right" type="button"></button>' \
                 else
                   ''
                 end

    '<div class="simple-slider">' \
    '  <div class="simple-slider__container swiper-container">' \
    '    <div class="swiper-wrapper">' \
    '      ' + images.join + '' \
    '    </div>' \
    '  </div>' \
    '' + navigation + '' \
    '</div>'
  end

  def img_html(url, alt)
    /\/spree\/products\/\d+\/slider_small\/(?<image_url>.+)/ =~ url
    image = Spree::Image.find_by(attachment_file_name: CGI.unescape(image_url))

    '<figure class="page__image">' \
    '  <img class="page__image-item" data-gallery="gallery1" data-src="' + image.attachment.url(:slider_large) + '" src="' + image.attachment.url(:slider_small) + '">' \
    '  <figcaption class="page__image-description">' + alt.to_s + '</figcaption>' \
    '</figure>'
  end
end
