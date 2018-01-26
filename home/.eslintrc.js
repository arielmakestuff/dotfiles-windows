/* global module */

module.exports = {
    // Extending recommended config and config derived from
    // eslint-config-prettier
    extends: ['eslint:recommended', 'prettier'],

    // Activating eslint-plugin-prettier
    plugins: ['prettier'],

    env: {
        browser: true,
        es6: true,
    },

    parserOptions: {
        sourceType: 'module',
    },

    rules: {
        // customizing prettier rules
        'prettier/prettier': [
            'error',
            {
                singleQuote: true,
                trailingComma: 'es5',
                tabWidth: 4,
            },
        ],

        eqeqeq: ['error', 'always'],

        indent: ['error', 4, { SwitchCase: 1 }],

        'linebreak-style': ['error', 'unix'],
        quotes: ['error', 'single'],

        semi: ['error', 'always'],

        'no-var': ['error'],
    },
};
