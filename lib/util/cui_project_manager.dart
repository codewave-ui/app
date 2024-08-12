import 'dart:convert';
import 'dart:io';

import 'package:codewave_ui/util/cui_command_line_interface.dart';
import 'package:codewave_ui/util/cui_logger.dart';
import 'package:codewave_ui/widget/common/dialog/cui_confirmation_dialog.dart';
import 'package:codewave_ui/widget/welcome_screen/new_project/main.dart';
import 'package:dart_casing/dart_casing.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:path/path.dart';

class CUIProjectManager {
  static final List<_BoilerplateContentConfig> _boilerplateConfigList = [
    _BoilerplateContentConfig(fileName: ".project.conf", content: """{
  "_browserName": "chrome",
  "_parallelExecution": 1,
  "_nodeJSPath": "\${node_path}",
  "_npmPath": "\${npm_path}"
}"""),
    _BoilerplateContentConfig(fileName: "tsconfig.json", content: """{
  "extends": "@tsconfig/node22/tsconfig.json",
  "compilerOptions": {
    "rootDir": ".",
    "target": "ES2022",
    "module": "Node16",
    "moduleResolution": "Node16",
    "sourceMap": true,
    "outDir": "out",
    "types": [
      "node",
      "@wdio/types"
    ]
  },
  "exclude": [
    "node_modules"
  ],
  "include": [
    "**/*.ts"
  ]
}"""),
    _BoilerplateContentConfig(
        fileName: "README.md",
        content: """# \${project_name} using Codewave UI Frameworks
Describe your project here...

## NodeJS
Version \${node_version}

## NPM
Version \${npm_version}
"""),
    _BoilerplateContentConfig(fileName: "package.json", content: """{
  "name": "\${project_name_kebab_case}",
  "version": "1.0.0",
  "scripts": {
    "build": "tsc && tsc-alias",
    "format": "prettier --write --ignore-unknown",
    "lint": "eslint --fix --cache"
  },
  "type": "module",
  "keywords": [
    "frontend",
    "test",
    "automation",
    "ui"
  ],
  "author": "Joshua Lauwrich Nandy (change this with your name)",
  "license": "MIT",
  "description": "",
  "packageManager": "pnpm@9.4.0+sha512.f549b8a52c9d2b8536762f99c0722205efc5af913e77835dbccc3b0b0b2ca9e7dc8022b78062c17291c48e88749c70ce88eb5a74f1fa8c4bf5e18bb46c8bd83a",
  "devDependencies": {
    "@eslint/eslintrc": "^3.1.0",
    "@eslint/js": "^9.5.0",
    "@tsconfig/node22": "^22.0.0",
    "@types/luxon": "^3.4.2",
    "@types/node": "^20.14.8",
    "@typescript-eslint/eslint-plugin": "^7.13.1",
    "@typescript-eslint/parser": "^7.13.1",
    "@wdio/types": "^8.39.0",
    "eslint": "^9.5.0",
    "eslint-config-prettier": "^9.1.0",
    "prettier": "^3.3.2",
    "tsc-alias": "^1.8.10",
    "typescript": "^5.5.2",
    "typescript-eslint": "^7.13.1",
    "webdriverio": "^8.39.0"
  },
  "dependencies": {
    "@codewave-ui/core": "latest",
    "@codewave-ui/cli": "latest"
  }
}
"""),
    _BoilerplateContentConfig(fileName: "LICENSE", content: """MIT License

Copyright (c) 2024 @codewave-ui

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""),
    _BoilerplateContentConfig(
        fileName: "eslint.config.mjs",
        content:
            """import typescriptEslint from '@typescript-eslint/eslint-plugin';
import globals from 'globals';
import tsParser from '@typescript-eslint/parser';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import js from '@eslint/js';
import { FlatCompat } from '@eslint/eslintrc';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
    baseDirectory: __dirname,
    recommendedConfig: js.configs.recommended,
    allConfig: js.configs.all
});

export default [
    ...compat.extends("eslint:recommended", "plugin:@typescript-eslint/recommended", "prettier"),
    {
        plugins: {
            "@typescript-eslint": typescriptEslint,
        },

        languageOptions: {
            globals: {
                ...globals.browser,
                ...globals.node
            },

            parser: tsParser,
            ecmaVersion: 12,
            sourceType: "module",
        },
        rules: {
            "@typescript-eslint/no-unused-vars": "error",
            "@typescript-eslint/consistent-type-definitions": ["error", "type"],
            "@typescript-eslint/no-explicit-any": "warn"
        },
    },
];"""),
    _BoilerplateContentConfig(fileName: ".prettierrc", content: """{
  "semi": true,
  "singleQuote": true,
  "arrowParens": "avoid",
  "printWidth": 100
}"""),
    _BoilerplateContentConfig(fileName: ".gitignore", content: """# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
.pnpm-debug.log*

# Diagnostic reports (https://nodejs.org/api/report.html)
report.[0-9]*.[0-9]*.[0-9]*.[0-9]*.json

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Directory for instrumented libs generated by jscoverage/JSCover
lib-cov

# Coverage directory used by tools like istanbul
coverage
*.lcov

# nyc test coverage
.nyc_output

# Grunt intermediate storage (https://gruntjs.com/creating-plugins#storing-task-files)
.grunt

# Bower dependency directory (https://bower.io/)
bower_components

# node-waf configuration
.lock-wscript

# Compiled binary addons (https://nodejs.org/api/addons.html)
build/Release

# Dependency directories
node_modules/
jspm_packages/

# Snowpack dependency directory (https://snowpack.dev/)
web_modules/

# TypeScript cache
*.tsbuildinfo

# Optional npm cache directory
.npm

# Optional eslint cache
.eslintcache

# Optional stylelint cache
.stylelintcache

# Microbundle cache
.rpt2_cache/
.rts2_cache_cjs/
.rts2_cache_es/
.rts2_cache_umd/

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variable files
.env
.env.development.local
.env.test.local
.env.production.local
.env.local

# parcel-bundler cache (https://parceljs.org/)
.cache
.parcel-cache

# Next.js build output
.next
out

# Nuxt.js build / generate output
.nuxt
dist

# Gatsby files
.cache/
# Comment in the public line in if your project uses Gatsby and not Next.js
# https://nextjs.org/blog/next-9-1#public-directory-support
# public

# vuepress build output
.vuepress/dist

# vuepress v2.x temp and cache directory
.temp
.cache

# Docusaurus cache and generated files
.docusaurus

# Serverless directories
.serverless/

# FuseBox cache
.fusebox/

# DynamoDB Local files
.dynamodb/

# TernJS port file
.tern-port

# Stores VSCode versions used for testing VSCode extensions
.vscode-test

# yarn v2
.yarn/cache
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz
.pnp.*

# Mac DS Store
.DS_Store

reports
"""),
    _BoilerplateContentConfig(
        fileName: "home.page.ts",
        content:
            """import {BasePage, Element, FindElement} from "@codewave-ui/core";


export default class HomePage extends BasePage {
  url(): string {
    return 'https://google.com';
  }

  @FindElement([
    {name: 'tag', value: 'textarea'},
    {name: 'xpath', value: "//*[@name='q']"}
  ])
  searchBar!: Element;
}
""",
        directory: "tests/home"),
    _BoilerplateContentConfig(
        fileName: "home.test.ts",
        content:
            """import {BaseConfig, BaseTest, TestCase, TestCaseContext, TestSuite} from "@codewave-ui/core";
import HomePage from './home.page.js';

@TestSuite('Home Test')
export default class HomeTest extends BaseTest {
  homePage: HomePage;

  constructor(config: BaseConfig) {
    super(config);
    this.homePage = new HomePage(config);
  }

  @TestCase('Search Bar Exist', {id: "TC001"})
  public async main({ driver }: TestCaseContext) {
    await driver.driver.navigateTo(this.homePage.url());
    await driver.keyword.verifyElementVisible(this.homePage.searchBar);
  }
  //
  // @TestCase('Typing on Search Bar', { id: 'TC002' })
  // public async main2({ driver }: TestCaseContext) {
  //   this.logger?.info('main2');
  // }
}
""",
        directory: "tests/home")
  ];

  static Future<void> generateNewProject(
      {required String projectName,
      required String projectPath,
      required String nodePath,
      required String npmPath}) async {
    String? npmVersion = await CUICommandLineInterface.findNpmVersion(npmPath);
    String? nodeVersion =
        await CUICommandLineInterface.findNodeVersion(nodePath);

    if (npmVersion == null || nodeVersion == null) {
      throw ArgumentError(
          "Can't find NodeJS or NPM version using provided path! NodeJS path: $nodePath | NPM path: $npmPath}");
    }

    Map<String, String> replacement = {
      "\${project_name}": projectName,
      "\${node_version}": nodeVersion,
      "\${npm_version}": npmVersion,
      "\${node_path}": nodePath,
      "\${npm_path}": npmPath,
      "\${project_name_kebab_case}": Casing.kebabCase(projectName),
    };

    Directory projectDirectory = Directory(projectPath);
    bool isDirExist = await projectDirectory.exists();
    if (!isDirExist) {
      await projectDirectory.create(recursive: true);
    } else {
      await projectDirectory.delete(recursive: true);
      await projectDirectory.create();
    }
    for (var item in _boilerplateConfigList) {
      File file;
      if (item.directory.isNotEmpty) {
        await Directory(projectPath + Platform.pathSeparator + item.directory)
            .create(recursive: true);
        file = File(projectPath +
            Platform.pathSeparator +
            item.directory +
            Platform.pathSeparator +
            item.fileName);
      } else {
        file = File(projectPath + Platform.pathSeparator + item.fileName);
      }
      bool isFileExist = await file.exists();
      if (!isFileExist) await file.create(recursive: true);
      await file.writeAsString(
          replacement.entries.fold(item.content,
              (value, element) => value.replaceAll(element.key, element.value)),
          flush: true);
    }

    Future<dynamic> futureResult = SmartDialog.show(
      builder: (context) {
        return CUIDialog(
            config: CUIConfirmationDialogConfig(
                width: 400,
                height: 150,
                title: "Git Initialization",
                content: "Are you want to setup or initialize git repository?",
                positiveAction: CUIConfirmationDialogPositiveAction(
                    actionText: "Yes",
                    onClick: () async {
                      await SmartDialog.dismiss(
                          status: SmartStatus.dialog, result: true);
                    }),
                negativeAction: CUIConfirmationDialogNegativeAction(
                    actionText: "No",
                    onClick: () async {
                      await SmartDialog.dismiss(
                          status: SmartStatus.dialog, result: false);
                    })));
      },
    );
    SmartDialog.dismiss(status: SmartStatus.loading);

    bool result = await futureResult;
    if (result == true) {
      await SmartDialog.show(builder: (context) {
        return GitInitializationForm(projectPath: projectPath);
      });
    }
  }

  static Future<bool> isProjectValid(String path) async {
    try {
      Directory dir = Directory(path);
      List<FileSystemEntity> fileLists = [];
      await for (var entity in dir.list(followLinks: false)) {
        fileLists.add(entity);
      }
      List<FileSystemEntity> importantFiles = fileLists
          .where((file) =>
              basename(file.path) == "tsconfig.json" ||
              basename(file.path) == "package.json")
          .toList();

      // fileLists.where((file) => file.)
      if (importantFiles.length != 2) {
        CUILogger.warn("Project is not valid!");
        return false;
      }

      File packageJsonFile = basename(importantFiles[0].path) == "package.json"
          ? File(importantFiles[0].path)
          : File(importantFiles[1].path);

      String rawPackageJsonFile = await packageJsonFile.readAsString();

      Map<String, dynamic> parsedPackageJson = jsonDecode(rawPackageJsonFile);

      String? coreVersion =
          parsedPackageJson['dependencies']['@codewave-ui/core'];
      String? cliVersion =
          parsedPackageJson['dependencies']['@codewave-ui/cli'];

      return true;
    } catch (err, s) {
      print(err);
      CUILogger.warn("Project is not valid!",
          error: err.toString(), stackTrace: s);
      return false;
    }
  }
}

class _BoilerplateContentConfig {
  final String fileName;
  final String directory;
  final String content;

  _BoilerplateContentConfig(
      {required this.fileName, required this.content, this.directory = ""});
}
