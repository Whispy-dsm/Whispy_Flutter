import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whispy_app_service/component/whispy_scaffold.dart';
import 'package:whispy_app_service/presentation/introduction/view/ui/introduction_screen.dart';

import '../../../core/images.dart';
import '../../../core/whispy/whispy_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WhispyScaffold(
      backgroundColor: WhispyColors.main2500,
      body: Stack(
        children: [
          const Positioned.fill(child: ParticleBackground()),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.whispyIcon,
                  width: 124.w,
                  height: 192.h,
                ),
                SizedBox(height: 24.h),

                //임시로
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const IntroductionScreen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    Images.whispyText,
                    width: 136.w,
                    height: 61.h,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ParticleBackground extends StatelessWidget {
  final int count;
  const ParticleBackground({super.key, this.count = 30});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    final particles = List.generate(
      count,
          (_) => Offset(
        random.nextDouble() * 1.sw,
        random.nextDouble() * 1.sh,
      ),
    );

    final sizes = List.generate(count, (_) => random.nextDouble() * 1.5 + 0.5);

    return CustomPaint(
      painter: ParticlePainter(
        particleCount: count,
        particles: particles,
        sizes: sizes,
        color: WhispyColors.white,
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final int particleCount;
  final List<Offset> particles;
  final List<double> sizes;
  final Color color;

  ParticlePainter({
    required this.particleCount,
    required this.particles,
    required this.sizes,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(0.2);

    for (int i = 0; i < particleCount; i++) {
      canvas.drawCircle(particles[i], sizes[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}