import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/extensions/translate_extensions.dart';
import 'package:immich_mobile/models/albums/album_search.model.dart';
import 'package:immich_mobile/services/app_settings.service.dart';
import 'package:immich_mobile/utils/hooks/app_settings_update_hook.dart';
import 'package:immich_mobile/widgets/settings/setting_group_title.dart';
import 'package:immich_mobile/widgets/settings/settings_radio_list_tile.dart';

class DefaultAlbumFilterSetting extends HookConsumerWidget {
  const DefaultAlbumFilterSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterIndex = useAppSettingsState(AppSettingsEnum.defaultAlbumFilter);
    final selected = QuickFilterMode.values[filterIndex.value];

    void onChanged(QuickFilterMode? value) {
      if (value != null) {
        filterIndex.value = value.index;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingGroupTitle(
          title: "default_album_filter".t(context: context),
          icon: Icons.photo_album_outlined,
        ),
        SettingsRadioListTile(
          groups: [
            SettingsRadioGroup(title: 'all'.t(context: context), value: QuickFilterMode.all),
            SettingsRadioGroup(title: 'shared_with_me'.t(context: context), value: QuickFilterMode.sharedWithMe),
            SettingsRadioGroup(title: 'my_albums'.t(context: context), value: QuickFilterMode.myAlbums),
          ],
          groupBy: selected,
          onRadioChanged: onChanged,
        ),
      ],
    );
  }
}
