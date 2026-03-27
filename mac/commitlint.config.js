module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',     // → minor bump (0.1.0 → 0.2.0)
        'fix',      // → patch bump (0.1.0 → 0.1.1)
        'break',    // → major bump (0.1.0 → 1.0.0)
        'docs',
        'style',
        'refactor',
        'perf',
        'test',
        'build',
        'ci',
        'chore',
        'revert',
        'wip',      // Bypass type for work-in-progress
      ],
    ],
  },
};
