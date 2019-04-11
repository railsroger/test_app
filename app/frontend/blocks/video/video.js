const videosElements = Array.prototype.slice.call(document.querySelectorAll('.video'));
const videoContent = document.querySelectorAll('[data-video-content]');

videosElements.forEach(videoItem => {
  if (!videoItem.querySelector('video').autoplay) {

    const playButton = document.createElement('button');
    playButton.type = 'button';
    playButton.classList.add('video__button-play');
    videoItem.appendChild(playButton);

    const pauseButton = document.createElement('button');
    pauseButton.type = 'button';
    pauseButton.style.display = 'none';
    pauseButton.classList.add('video__button-pause');
    videoItem.appendChild(pauseButton);

    videoItem.addEventListener('click', () => {
      const video = videoItem.querySelector('video');

      const tl = new TimelineMax();

      if (video.paused) {
        tl.set(playButton, {opacity: 1, scale: 1, clearProps: 'display'})
          .set(videoContent, {opacity: 1})
          .to(playButton, .5, {opacity: 0, scale: 1.5})
          .to(videoContent, .5, {opacity: 0}, '-=.5')
          .set(playButton, {display: 'none', clearProps: 'scale'})
          .set(pauseButton, {opacity: 0});

        video.play();
        videoItem.classList.add('video_played');
      } else {
        tl.set(pauseButton, {opacity: 1, scale: 1, clearProps: 'display'})
          .to(pauseButton, .5, {opacity: 0, scale: 1.5})
          .to(videoContent, .5, {opacity: 1}, '-=.5')
          .set(pauseButton, {display: 'none', clearProps: 'scale'})
          .set(playButton, {opacity: 0});

        video.pause();
        videoItem.classList.remove('video_played');
      }
    });
  }
});
