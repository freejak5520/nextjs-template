#!/bin/bash

set -e

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Please enter a project name."
  exit 1
fi

npx create-next-app@latest "$PROJECT_NAME" --ts --tailwind --eslint --app --src-dir --use-npm --no-import-alias

cd "$PROJECT_NAME" || exit

PROJECT_DIR=$(pwd)

npm install -D prettier eslint-config-prettier eslint-plugin-prettier prettier-plugin-tailwindcss
npm install -D jest jest-environment-jsdom @testing-library/react @testing-library/jest-dom @types/jest

cp "$BASEDIR/root/tsconfig.json" "$PROJECT_DIR/tsconfig.json"
cp "$BASEDIR/root/.prettierrc" "$PROJECT_DIR/.prettierrc"
cp "$BASEDIR/root/.eslintrc.json" "$PROJECT_DIR/.eslintrc.json"
cp "$BASEDIR/root/jest.config.js" "$PROJECT_DIR/jest.config.js"

npx storybook@latest init

echo "Project creation is complete."
