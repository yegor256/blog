// SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
// SPDX-License-Identifier: MIT

const { configs } = require('@eslint/js');

module.exports = [
  {
    ignores: ['dist/', 'node_modules/']
  },
  {
    ...configs.all,
    files: ['assets/js/**.js'],
    languageOptions: {
      ecmaVersion: 2019,
      sourceType: 'module'
    },
    rules: {
      ...configs.all.rules,
      'sort-vars': 'off',
      'capitalized-comments': 'off',
      'no-alert': 'off',
      'no-magic-numbers': 'off',
      'indent': ['error', 2],
      'max-len': ['error', { code: 100 }]
    }
  }
];
