const tabsMixin = { // eslint-disable-line
  data() {
    return {
      activeTabIndex: 1
    };
  },

  methods: {
    hookTabEnter(el, done) {
      const tl = new TimelineLite({onComplete: done});

      tl.set(el, {opacity: 0, transition: 'none'})
        .to(el, .3, {opacity: 1, clearProps: 'opacity, transition'});
    },

    hookTabLeave(el, done) {
      const tl = new TimelineLite({onComplete: done});

      tl.set(el, {opacity: 1, position: 'absolute', transition: 'none'})
        .to(el, .3, {opacity: 0, clearProps: 'position'});
    }
  }
};

export default tabsMixin;
