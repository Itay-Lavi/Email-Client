import 'package:flutter_dotenv/flutter_dotenv.dart';

final hostname = dotenv.env['HOSTNAME']!;

List<String> specialUseAttribTypes = [
  r'\Trash',
  r'\Sent',
  r'\Important',
  r'\Drafts',
  r'\All',
  r'\Flagged',
  r'\Junk'
];

List<String> globalflags = [
  r'\flagged',
  r'\seen',
  r'\recent',
  r'\answered',
  r'\deleted',
  r'\draft',
];
