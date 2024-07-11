import 'package:media_mingle/view/components/animations/lottie_animation_view.dart';
import 'package:media_mingle/view/components/animations/models/lottie_animation.dart';

class DataNotFoundAnimationView extends LottieAnimationView {
  const DataNotFoundAnimationView({super.key})
      : super(
          animation: LottieAnimation.dataNotFound,
        );
}
