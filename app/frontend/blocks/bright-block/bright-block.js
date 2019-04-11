const brightBlockColumns = Array.prototype.slice.call(document.querySelectorAll('.bright-block__column'));
const brightBlockCovers = Array.prototype.slice.call(document.querySelectorAll('.bright-block__cover'));

document.addEventListener('DOMContentLoaded', () => {
  brightBlockColumns.forEach((item, index) => {
    item.addEventListener('click', e => {
      e.preventDefault();

      brightBlockColumns.forEach((item2, index2) => {
        if (item !== item2) {
          item2.classList.remove('active');
          brightBlockCovers[index2].classList.remove('active');
        }
      });

      item.classList.toggle('active');
      brightBlockCovers[index].classList.toggle('active');
    });
  });

  brightBlockCovers.forEach(item => {
    item.addEventListener('click', () => {
      item.classList.remove('active');
    });
  });
});
