/// GENERATED CODE - DO NOT MODIFY BY HAND

/// ***************************************************************************
/// *                            pubspec_generator                            * 
/// ***************************************************************************

/*
  
  MIT License
  
  Copyright (c) 2022 Plague Fox
  
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
const String version = r'1.0.0+1';

/// The major version number: "1" in "1.2.3".
const int major = 1;

/// The minor version number: "2" in "1.2.3".
const int minor = 0;

/// The patch version number: "3" in "1.2.3".
const int patch = 0;

/// The pre-release identifier: "foo" in "1.2.3-foo".
const List<String> pre = <String>[];

/// The build identifier: "foo" in "1.2.3+foo".
const List<String> build = <String>[r'1'];

/// Build date in Unix Time (in seconds)
const int timestamp = 1670519905;

/// Name [name]
const String name = r'tab_router_example';

/// Description [description]
const String description = r'tab_router_example';

/// Repository [repository]
const String repository = r'';

/// Issue tracker [issue_tracker]
const String issueTracker = r'';

/// Homepage [homepage]
const String homepage = r'';

/// Documentation [documentation]
const String documentation = r'';

/// Publish to [publish_to]
const String publishTo = r'none';

/// Environment
const Map<String, String> environment = <String, String>{
  'sdk': '>=2.19.0-374.1.beta <3.0.0',
  'flutter': '>=2.19.0-374.1.beta <3.0.0',
};

/// Dependencies
const Map<String, Object> dependencies = <String, Object>{
  'flutter': <String, Object>{
    'sdk': r'flutter',
  },
  'flutter_localizations': <String, Object>{
    'sdk': r'flutter',
  },
  'collection': r'^1.17.0',
  'meta': r'^1.7.0',
  'intl': r'^0.17.0',
  'l': r'^3.2.0',
  'path': r'^1.8.2',
  'shared_preferences': r'^2.0.15',
  'tab_router': <String, Object>{
    'path': r'packages/tab_router',
  },
};

/// Developer dependencies
const Map<String, Object> devDependencies = <String, Object>{
  'flutter_test': <String, Object>{
    'sdk': r'flutter',
  },
  'dart_code_metrics': r'^5.0.1',
  'build': r'^2.0.0',
  'build_runner': r'^2.0.2',
  'build_test': r'^2.0.0',
  'flutter_gen_runner': r'any',
  'pubspec_generator': r'^3.0.1',
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
    'assets': <Object>[
      r'assets/data/',
      r'assets/images/',
    ],
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
