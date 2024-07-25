import 'package:media_mingle/view/components/constants/strings.dart';
import 'package:media_mingle/view/components/dialogs/alert_dialog_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class DeleteDialog extends AlertDialogModel {
  const DeleteDialog({
    required String titleOfObjectToDelete,
  }) : super(
            title: '${Strings.delete} $titleOfObjectToDelete',
            message:
                '${Strings.areYouSureYouWantToDeleteThis} $titleOfObjectToDelete',
            buttons: const {
              Strings.cancel: false,
              Strings.delete: true,
            });
}
