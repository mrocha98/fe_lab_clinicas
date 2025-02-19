import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/src/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final class LabClinicasLoader extends AsyncOverlay {
  LabClinicasLoader()
      : super(
          id: 0,
          builder: (BuildContext context, AsyncValue<RouteSettings> settings) {
            return Center(
              child: SizedBox(
                width: context.screenWidthPercent(.8),
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.orange,
                  size: 50,
                ),
              ),
            );
          },
        );
}
