///
//  Generated code. Do not modify.
//  source: apm.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use logDescriptor instead')
const Log$json = const {
  '1': 'Log',
  '2': const [
    const {'1': 'project', '3': 1, '4': 1, '5': 9, '10': 'project'},
    const {'1': 'span', '3': 10, '4': 1, '5': 9, '9': 0, '10': 'span', '17': true},
    const {'1': 'event', '3': 20, '4': 1, '5': 9, '10': 'event'},
    const {'1': 'time', '3': 30, '4': 1, '5': 5, '10': 'time'},
    const {'1': 'name', '3': 31, '4': 1, '5': 9, '9': 1, '10': 'name', '17': true},
    const {'1': 'level', '3': 32, '4': 1, '5': 5, '10': 'level'},
    const {'1': 'stack', '3': 50, '4': 1, '5': 9, '9': 2, '10': 'stack', '17': true},
    const {'1': 'tags', '3': 100, '4': 3, '5': 11, '6': '.apm.Log.TagsEntry', '10': 'tags'},
    const {'1': 'breadcrumbs', '3': 200, '4': 3, '5': 9, '10': 'breadcrumbs'},
  ],
  '3': const [Log_TagsEntry$json],
  '8': const [
    const {'1': '_span'},
    const {'1': '_name'},
    const {'1': '_stack'},
  ],
};

@$core.Deprecated('Use logDescriptor instead')
const Log_TagsEntry$json = const {
  '1': 'TagsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Log`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logDescriptor = $convert.base64Decode('CgNMb2cSGAoHcHJvamVjdBgBIAEoCVIHcHJvamVjdBIXCgRzcGFuGAogASgJSABSBHNwYW6IAQESFAoFZXZlbnQYFCABKAlSBWV2ZW50EhIKBHRpbWUYHiABKAVSBHRpbWUSFwoEbmFtZRgfIAEoCUgBUgRuYW1liAEBEhQKBWxldmVsGCAgASgFUgVsZXZlbBIZCgVzdGFjaxgyIAEoCUgCUgVzdGFja4gBARImCgR0YWdzGGQgAygLMhIuYXBtLkxvZy5UYWdzRW50cnlSBHRhZ3MSIQoLYnJlYWRjcnVtYnMYyAEgAygJUgticmVhZGNydW1icxo3CglUYWdzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AUIHCgVfc3BhbkIHCgVfbmFtZUIICgZfc3RhY2s=');
@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = const {
  '1': 'Transaction',
  '2': const [
    const {'1': 'project', '3': 1, '4': 1, '5': 9, '10': 'project'},
    const {'1': 'id', '3': 10, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'operation', '3': 50, '4': 1, '5': 9, '10': 'operation'},
    const {'1': 'description', '3': 100, '4': 1, '5': 9, '9': 0, '10': 'description', '17': true},
  ],
  '8': const [
    const {'1': '_description'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode('CgtUcmFuc2FjdGlvbhIYCgdwcm9qZWN0GAEgASgJUgdwcm9qZWN0Eg4KAmlkGAogASgJUgJpZBIcCglvcGVyYXRpb24YMiABKAlSCW9wZXJhdGlvbhIlCgtkZXNjcmlwdGlvbhhkIAEoCUgAUgtkZXNjcmlwdGlvbogBAUIOCgxfZGVzY3JpcHRpb24=');
