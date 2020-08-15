module.exports = {
  defaultBrowser: 'Firefox',
  options: {
    hideIcon: true,
  },
  rewrite: [
    {
      match: ({ url }) => url.protocol === 'http',
      url: {
        protocol: 'https',
      },
    },
    {
      match: ({ url }) => url.search.includes('utm_'),
      url({ url }) {
        const search = url.search
          .split('&')
          .filter((part) => !part.startsWith('utm_'));
        return {
          ...url,
          search: search.join('&'),
        };
      },
    },
  ],
  handlers: [
    {
      match: 'open.spotify.com*',
      browser: 'Spotify',
    },
  ],
};
