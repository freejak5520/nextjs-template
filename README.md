# Next.js template

Next.js 프로젝트를 생성할 때 반복적으로 설정이 필요한 과정을 정리합니다.

아래의 라이브러리, 프레임워크가 포함되어 있습니다.

- Next.js
- TypeScript
- TailwindCSS
- Prettier
- Jest
- Storybook
- eslint
    - eslint-config-next
    - eslint-plugin-prettier
    - eslint-config-prettier
    - eslint-plugin-storybook


## Next.js 프로젝트 만들기

명령어 입력

```bash
npx create-next-app@latest
```

프로젝트 이름 및 기본 설정 선택

```
✔ What is your project named? … nextjs-template
✔ Would you like to use TypeScript? … Yes
✔ Would you like to use ESLint? … Yes
✔ Would you like to use Tailwind CSS? … Yes
✔ Would you like to use `src/` directory? … Yes
✔ Would you like to use App Router? (recommended) … Yes
✔ Would you like to customize the default import alias (@/*)? … No
Creating a new Next.js app in /Users/jake/Developments/Projects/nextjs/nextjs-template.
```

개발 서버 실행

```bash
npm run dev
```

http://localhost:3000/ 로 접속

## TS Config 적용

tsconfig.json에 권장 설정을 적용합니다.

[https://velog.io/@freejak5520/번역The-TSConfig-Cheet-Sheet](https://velog.io/@freejak5520/%EB%B2%88%EC%97%ADThe-TSConfig-Cheet-Sheet)

```json
{
  "compilerOptions": {
    "allowJs": true,
    "esModuleInterop": true,
    "incremental": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "module": "esnext",
    "moduleDetection": "force",
    "moduleResolution": "bundler",
    "noEmit": true,
    "noImplicitOverride": true,
    "noUncheckedIndexedAccess": true,
    "resolveJsonModule": true,
    "skipLibCheck": true,
    "strict": true,
    "verbatimModuleSyntax": true,
    "lib": [
      "dom",
      "dom.iterable",
      "esnext"
    ],
    "paths": {
      "@/*": [
        "./src/*"
      ]
    },
    "plugins": [
      {
        "name": "next"
      }
    ],
  },
  "exclude": [
    "node_modules",
  ],
  "include": [
    "next-env.d.ts",
    "**/*.ts",
    "**/*.tsx",
    ".next/types/**/*.ts",
  ]
}
```

## tsc 스크립트 추가

tsc 명령어를 자주 사용하기 때문에 스크립트에 추가합니다.

```jsonc
{
  // ...
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "tsc": "tsc" // Add tsc script
  },
  // ...
}

```

사용 예: tsc —watch 실행

```bash
npm run tsc -- -w
```

## Prettier

Prettier와 관련 플러그인을 설치하고 rule 설정을 통해 save 시 자동 포매팅을 적용합니다.

Prettier 및 eslint, tailwindcss 관련 플러그인 설치

```bash
npm install -D prettier eslint-config-prettier eslint-plugin-prettier prettier-plugin-tailwindcss
```

.prettierrc 파일 추가

```json
{
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": false,
  "quoteProps": "as-needed",
  "trailingComma": "all",
  "bracketSpacing": true,
  "bracketSameLine": false,
  "arrowParens": "always",
  "printWidth": 80,
  "endOfLine": "lf",
  "plugins": ["prettier-plugin-tailwindcss"]
}
```

eslint 설정 eslintrc.json

```json
{
  "extends": [
    "next/core-web-vitals",
    "plugin:prettier/recommended"
  ],
  "rules": {
    "prettier/prettier": [
      "error"
    ]
  }
}

```

VS Code 설정

- ESLint 확장 설치
- 설정에 아래 내용 추가해서 저장 시 format on save 적용

```jsonc
{
  // ...
  "[javascript]": {
      "editor.codeActionsOnSave": {
          "source.fixAll": "always"
      }
  },
  "[javascriptreact]": {
      "editor.codeActionsOnSave": {
          "source.fixAll": "always"
      }
  },
  "[typescript]": {
      "editor.codeActionsOnSave": {
          "source.fixAll": "always"
      }
  },
  "[typescriptreact]": {
      "editor.codeActionsOnSave": {
          "source.fixAll": "always"
      }
  },
  // ...
}
```

JavaScript, TypeScript 외 파일들은 VS Code Prettier 확장을 사용해 적용합니다.

## Jest

https://nextjs.org/docs/app/building-your-application/testing/jest

테스트라이브러리로 jest를 설치하고 설정합니다.

install jest

```bash
npm install -D jest jest-environment-jsdom @testing-library/react @testing-library/jest-dom @types/jest
```

init jest

```bash
npm init jest@latest
```

Create jest.config.js

```javascript
const nextJest = require("next/jest");

/** @type {import('jest').Config} */
const createJestConfig = nextJest({
  // Provide the path to your Next.js app to load next.config.js and .env files in your test environment
  dir: "./",
});

// Add any custom config to be passed to Jest
const config = {
  coverageProvider: "v8",
  testEnvironment: "jsdom",
  // Add more setup options before each test is run
  // setupFilesAfterEnv: ['<rootDir>/jest.setup.ts'],
};

// createJestConfig is exported this way to ensure that next/jest can load the Next.js config which is async
module.exports = createJestConfig(config);

```
