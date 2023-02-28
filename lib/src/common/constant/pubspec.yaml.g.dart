/// GENERATED CODE - DO NOT MODIFY BY HAND

/// ***************************************************************************
/// *                            pubspec_generator                            *
/// ***************************************************************************

/*
  
  MIT License
  
  Copyright (c) 2023 Plague Fox
  
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
  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
   
 */

// The pubspec file:
// https://dart.dev/tools/pub/pubspec

// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: unnecessary_raw_strings
// ignore_for_file: use_raw_strings
// ignore_for_file: avoid_escaping_inner_quotes
// ignore_for_file: prefer_single_quotes

/// Current app version
const String version = r'0.0.1';

/// The major version number: "1" in "1.2.3".
const int major = 0;

/// The minor version number: "2" in "1.2.3".
const int minor = 0;

/// The patch version number: "3" in "1.2.3".
const int patch = 1;

/// The pre-release identifier: "foo" in "1.2.3-foo".
const List<String> pre = <String>[];

/// The build identifier: "foo" in "1.2.3+foo".
const List<String> build = <String>[];

/// Build date in Unix Time (in seconds)
const int timestamp = 1677586659;

/// Name [name]
const String name = r'app';

/// Description [description]
const String description = r'Application Performance Monitoring (APM)';

/// Repository [repository]
const String repository = r'';

/// Issue tracker [issue_tracker]
const String issueTracker = r'';

/// Homepage [homepage]
const String homepage = r'https://github.com/PlugFox/apm';

/// Documentation [documentation]
const String documentation = r'';

/// Publish to [publish_to]
const String publishTo = r'none';

/// Environment
const Map<String, String> environment = <String, String>{
  'sdk': '>=2.19.2 <4.0.0',
  'flutter': '>=2.19.2 <4.0.0',
};

/// Dependencies
const Map<String, Object> dependencies = <String, Object>{
  'flutter': <String, Object>{
    'sdk': r'flutter',
  },
  'flutter_localizations': <String, Object>{
    'sdk': r'flutter',
  },
  'intl': r'any',
  'collection': r'any',
  'async': r'any',
  'meta': r'any',
  'database': <String, Object>{
    'path': r'package/database',
  },
  'server': <String, Object>{
    'path': r'package/server',
  },
  'entity': <String, Object>{
    'path': r'package/entity',
  },
};

/// Developer dependencies
const Map<String, Object> devDependencies = <String, Object>{
  'flutter_test': <String, Object>{
    'sdk': r'flutter',
  },
  'integration_test': <String, Object>{
    'sdk': r'flutter',
  },
  'flutter_lints': r'^2.0.0',
  'build_runner': r'^2.3.3',
  'flutter_launcher_icons': r'any',
  'flutter_native_splash': r'any',
  'pubspec_generator': r'any',
  'flutter_gen_runner': r'any',
};

/// Dependency overrides
const Map<String, Object> dependencyOverrides = <String, Object>{};

/// Executables
const Map<String, Object> executables = <String, Object>{};

/// Source data from pubspec.yaml
const Map<String, Object> source = <String, Object>{
  'name': name,
  'description': description,
  'repository': repository,
  'issue_tracker': issueTracker,
  'homepage': homepage,
  'documentation': documentation,
  'publish_to': publishTo,
  'version': version,
  'environment': environment,
  'dependencies': dependencies,
  'dev_dependencies': devDependencies,
  'dependency_overrides': dependencyOverrides,
  'flutter': <String, Object>{
    'uses-material-design': true,
  },
  'flutter_intl': <String, Object>{
    'enabled': true,
    'class_name': r'GeneratedLocalization',
    'main_locale': r'en',
    'arb_dir': r'lib/src/common/localization',
    'output_dir': r'lib/src/common/localization/generated',
    'use_deferred_loading': false,
  },
  'flutter_gen': <String, Object>{
    'output': r'lib/src/common/constant/',
    'line_length': 120,
  },
};
