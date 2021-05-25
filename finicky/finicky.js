module.exports = {
  defaultBrowser: 'Firefox',
  options: {
    hideIcon: true,
  },
  rewrite: [
    // force https
    {
      match: ({ url }) => url.protocol === 'http',
      url: {
        protocol: 'https',
      },
    },

    // replace google with ddg
    {
      match: finicky.matchDomains(['google.com']),
      url: 'https://duckduckgo.com',
    },

    // remove tracking
    {
      match: () => true, // Execute rewrite on all incoming urls to make this example easier to understand
      url({ url }) {
        const removeKeysStartingWith = ['utm_', 'uta_']; // Remove all query parameters beginning with these strings
        const removeKeys = ['fblid', 'gclid']; // Remove all query parameters matching these keys

        const search = url.search
          .split('&')
          .map((parameter) => parameter.split('='))
          .filter(
            ([key]) =>
              !removeKeysStartingWith.some((startingWith) =>
                key.startsWith(startingWith)
              )
          )
          .filter(
            ([key]) => !removeKeys.some((removeKey) => key === removeKey)
          );

        return {
          ...url,
          search: search.map((parameter) => parameter.join('=')).join('&'),
        };
      },
    },
  ],
  handlers: [
    {
      match: 'open.spotify.com/*',
      browser: 'Spotify',
    },
    {
      match: 'notion.so*',
      browser: 'Notion',
    },
  ],
};
