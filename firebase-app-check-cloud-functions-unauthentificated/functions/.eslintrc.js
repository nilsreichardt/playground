module.exports = {
  "env": {
      "browser": true,
      "es6": true
  },
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
      "project": "tsconfig.json",
      "tsconfigRootDir": __dirname,
      "sourceType": "module"
  },
  "plugins": [
      "eslint-plugin-import",
      "@typescript-eslint",
  ],
  "ignorePatterns": ['.eslintrc.js'],
  "rules": {
      "@typescript-eslint/adjacent-overload-signatures": "error",
      "@typescript-eslint/no-empty-function": "error",
      "@typescript-eslint/no-empty-interface": "warn",
      "@typescript-eslint/no-floating-promises": "error",
      "@typescript-eslint/no-namespace": "off",
      "@typescript-eslint/no-unnecessary-type-assertion": "error",
      "@typescript-eslint/prefer-for-of": "warn",
      "@typescript-eslint/triple-slash-reference": "error",
      "@typescript-eslint/unified-signatures": "warn",
      "comma-dangle": "warn",
      "constructor-super": "error",
      "eqeqeq": [
          "warn",
          "always",
          {
              "null": "ignore",
          }
      ],
      "import/no-deprecated": "warn",
      "import/no-unassigned-import": "warn",
      "no-cond-assign": "error",
      "no-duplicate-case": "error",
      "no-duplicate-imports": "error",
      "no-empty": [
          "error",
          {
              "allowEmptyCatch": true
          }
      ],
      "no-invalid-this": "error",
      "no-new-wrappers": "error",
      "no-redeclare": "error",
      "no-sequences": "error",
      "no-throw-literal": "error",
      "no-unsafe-finally": "error",
      "no-unused-labels": "error",
      "no-var": "warn",
      "no-void": "error",
      "prefer-const": "warn"
  }
};
