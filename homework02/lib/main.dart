import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

ThemeData _minecraftTheme() {
  const mcGreen = Color(0xFF5A9E38);
  const mcDarkGreen = Color(0xFF3D6828);
  const mcDirt = Color(0xFF8B6914);
  const mcStone = Color(0xFF9D9D97);
  const colorScheme = ColorScheme.light(
    primary: mcGreen,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFA8E063),
    onPrimaryContainer: Color(0xFF1A2E0F),
    secondary: mcDirt,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFD4A574),
    onSecondaryContainer: Color(0xFF3D2914),
    tertiary: mcStone,
    onTertiary: Color(0xFF2D2D2A),
    tertiaryContainer: Color(0xFFC6C6C3),
    surface: Color(0xFFF5E6C8),
    onSurface: Color(0xFF2D1F0E),
    error: Color(0xFFB00020),
    outline: mcDarkGreen,
    outlineVariant: mcStone,
  );

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: const Color(0xFF5A9E38),
  );

  final cyber = GoogleFonts.audiowideTextTheme(base.textTheme);
  return base.copyWith(
    textTheme: cyber.copyWith(
      displayLarge: GoogleFonts.audiowide(textStyle: cyber.displayLarge, fontSize: 40),
      headlineSmall: GoogleFonts.audiowide(
        textStyle: cyber.headlineSmall,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
      titleLarge: GoogleFonts.audiowide(textStyle: cyber.titleLarge, fontSize: 20, fontWeight: FontWeight.w400),
      bodyLarge: GoogleFonts.audiowide(textStyle: cyber.bodyLarge, fontSize: 17, height: 1.4),
      bodyMedium: GoogleFonts.audiowide(textStyle: cyber.bodyMedium, fontSize: 15, height: 1.45),
      labelLarge: GoogleFonts.audiowide(textStyle: cyber.labelLarge, fontSize: 15, fontWeight: FontWeight.w400),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: mcGreen,
      foregroundColor: Colors.white,
      elevation: 6,
      shadowColor: mcDarkGreen,
      centerTitle: true,
      titleTextStyle: GoogleFonts.audiowide(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.25,
        letterSpacing: 0.5,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 6,
      shadowColor: Colors.black54,
      color: const Color(0xFFE8DCC8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: mcDarkGreen, width: 3),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group 2 Profile App',
      theme: _minecraftTheme(),
      home: const TeamProfilePage(),
    );
  }
}

/// 8×8 pixel creeper-style face (original layout — not official Mojang artwork).
class _CreeperFace extends StatelessWidget {
  final double size;

  const _CreeperFace({this.size = 40});

  static const List<List<int>> _pixels = [
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 2, 2, 2, 2, 0, 1],
    [1, 2, 2, 0, 0, 2, 2, 1],
    [1, 2, 2, 2, 2, 2, 2, 1],
    [1, 0, 2, 2, 2, 2, 0, 1],
    [1, 2, 0, 2, 2, 0, 2, 1],
    [1, 2, 0, 2, 2, 0, 2, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
  ];

  static Color _pixel(int v) {
    return switch (v) {
      0 => const Color(0xFF5A9E38),
      1 => const Color(0xFF2D4A1F),
      2 => const Color(0xFF1A1A1A),
      _ => const Color(0xFF5A9E38),
    };
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
        boxShadow: const [
          BoxShadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 0),
        ],
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: Column(
          children: List.generate(8, (y) {
            return Expanded(
              child: Row(
                children: List.generate(8, (x) {
                  return Expanded(
                    child: Container(color: _pixel(_pixels[y][x])),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class TeamProfilePage extends StatefulWidget {
  const TeamProfilePage({super.key});

  @override
  State<TeamProfilePage> createState() => _TeamProfilePageState();
}

class _TeamProfilePageState extends State<TeamProfilePage> {
  static const double _carouselViewportFraction = 0.86;
  /// Virtual length so wrap next/prev is always a +1/-1 page (infinite carousel).
  static const int _virtualPageCount = 120000;

  late final int _baseVirtualPage;
  late final PageController _pageController;

  final List<TeamMember> _members = const [
    TeamMember(
      name: 'Mumtaz',
      country: 'Germany',
      role: 'Flutter Developer',
      hobbies: 'UI design, football, photography',
      motto: 'Build simple, build useful.',
      imagePath: 'assets/images/mumtaz.jpg',
    ),
    TeamMember(
      name: 'Martins',
      country: 'Latvia',
      role: 'Backend Engineer',
      hobbies: 'Orienteering, gaming, reading',
      motto: 'Happy to be here.',
      imagePath: 'assets/images/martins.jpg',
    ),
    TeamMember(
      name: 'Haseeb',
      country: 'Pakistan',
      role: 'UI/UX Designer',
      hobbies: 'Travel, music, chess',
      motto: 'Quality is everyone\'s job.',
      imagePath: 'assets/images/haseeb.jpg',
    ),
  ];

  int get _n => _members.length;

  @override
  void initState() {
    super.initState();
    final half = _virtualPageCount ~/ 2;
    _baseVirtualPage = half - (half % _n);
    _pageController = PageController(
      viewportFraction: _carouselViewportFraction,
      initialPage: _baseVirtualPage,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const Duration _pageAnim = Duration(milliseconds: 280);
  static const Curve _pageCurve = Curves.fastOutSlowIn;

  void _goRelative(int delta) {
    if (!_pageController.hasClients || !_pageController.position.hasPixels) {
      return;
    }
    final cur = _pageController.page!.round();
    final target = cur + delta;
    if (target < 0 || target >= _virtualPageCount) {
      return;
    }
    _pageController.animateToPage(
      target,
      duration: _pageAnim,
      curve: _pageCurve,
    );
  }

  void _nextMember() => _goRelative(1);

  void _previousMember() => _goRelative(-1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: _CreeperFace(size: 34),
          ),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Group 2 Profile App',
            style: GoogleFonts.audiowide(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.25,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7AB8FF),
              Color(0xFFB8E8D0),
              Color(0xFF5A9E38),
              Color(0xFF6B4F2A),
              Color(0xFF5D3A1A),
            ],
            stops: [0.0, 0.28, 0.52, 0.78, 1.0],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 14),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC6A66E),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFF4A3728), width: 3),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'We build apps that feel simple on the surface and solid underneath — '
                    'crafted with Flutter, care, and a bias for clarity.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF2D1F0E),
                      height: 1.35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                clipBehavior: Clip.none,
                physics: const ClampingScrollPhysics(),
                itemCount: _virtualPageCount,
                allowImplicitScrolling: true,
                itemBuilder: (context, index) {
                  final i = index % _n;
                  return _CarouselProfilePage(
                    pageController: _pageController,
                    pageIndex: index,
                    fallbackVirtualPage: _baseVirtualPage,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 440),
                            child: MemberCard(
                              member: _members[i],
                              memberIndex: i,
                              memberCount: _n,
                              onPrevious: _previousMember,
                              onNext: _nextMember,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Peeking carousel: neighbors stay visible, dimmed and scaled while the active card swipes.
class _CarouselProfilePage extends StatelessWidget {
  final PageController pageController;
  final int pageIndex;
  final int fallbackVirtualPage;
  final Widget child;

  const _CarouselProfilePage({
    required this.pageController,
    required this.pageIndex,
    required this.fallbackVirtualPage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, _) {
        var page = fallbackVirtualPage.toDouble();
        if (pageController.hasClients && pageController.position.hasPixels) {
          page = pageController.page ?? fallbackVirtualPage.toDouble();
        }
        final dist = (pageIndex - page).abs();
        final scale = (1.0 - dist * 0.11).clamp(0.86, 1.0);
        final opacity = (1.0 - dist * 0.45).clamp(0.28, 1.0);
        final translateY = dist * 8.0;

        return RepaintBoundary(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(0, translateY),
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.low,
                  child: IgnorePointer(
                    ignoring: dist > 0.62,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MemberCard extends StatelessWidget {
  final TeamMember member;
  final int memberIndex;
  final int memberCount;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const MemberCard({
    super.key,
    required this.member,
    required this.memberIndex,
    required this.memberCount,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 24),
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.45),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Color(0xFF3D6828), width: 3),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8DCC8),
              Color(0xFFD4C4A8),
              Color(0xFFE8DCC8),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ProfileNavArrow(
                      icon: Icons.chevron_left_rounded,
                      tooltip: 'Previous profile',
                      onPressed: onPrevious,
                    ),
                    const SizedBox(width: 4),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF5A9E38),
                              Color(0xFF3D6828),
                            ],
                          ),
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            width: 112,
                            height: 112,
                            child: _MemberPhoto(
                              imagePath: member.imagePath,
                              colorScheme: colorScheme,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    _ProfileNavArrow(
                      icon: Icons.chevron_right_rounded,
                      tooltip: 'Next profile',
                      onPressed: onNext,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(memberCount, (i) {
                  final active = i == memberIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 22 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: active ? const Color(0xFF2D4A1F) : const Color(0xFF6B4F2A),
                        width: 1,
                      ),
                      color: active
                          ? const Color(0xFF5A9E38)
                          : const Color(0xFFC6C6C3),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  member.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.6,
                    color: const Color(0xFF2D1F0E),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Skills',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF2D1F0E),
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      _SkillPill(
                        label: 'Flutter',
                        fillColor: Color(0xFFBBDEFB),
                        borderColor: Color(0xFF0D47A1),
                        textColor: Color(0xFF01579B),
                      ),
                      SizedBox(width: 10),
                      _SkillPill(
                        label: 'Dart',
                        fillColor: Color(0xFFB2EBF2),
                        borderColor: Color(0xFF006064),
                        textColor: Color(0xFF004D40),
                      ),
                      SizedBox(width: 10),
                      _SkillPill(
                        label: 'Material UI',
                        fillColor: Color(0xFFE1BEE7),
                        borderColor: Color(0xFF6A1B9A),
                        textColor: Color(0xFF4A148C),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _InfoRow(
                icon: Icons.flag_rounded,
                label: 'Country',
                value: member.country,
                fillColor: const Color(0xFFFFD166),
                borderColor: const Color(0xFFE67700),
                labelColor: const Color(0xFF9D4E00),
                valueColor: const Color(0xFF0F172A),
              ),
              _InfoRow(
                icon: Icons.work_outline_rounded,
                label: 'Role',
                value: member.role,
                fillColor: const Color(0xFF8EFFCD),
                borderColor: const Color(0xFF059669),
                labelColor: const Color(0xFF047857),
                valueColor: const Color(0xFF0F172A),
              ),
              _InfoRow(
                icon: Icons.interests_outlined,
                label: 'Hobbies',
                value: member.hobbies,
                fillColor: const Color(0xFFFFB3C6),
                borderColor: const Color(0xFFE11D48),
                labelColor: const Color(0xFFBE123C),
                valueColor: const Color(0xFF0F172A),
              ),
              _InfoRow(
                icon: Icons.format_quote_rounded,
                label: 'Motto',
                value: member.motto,
                fillColor: const Color(0xFFD8B4FE),
                borderColor: const Color(0xFF7C3AED),
                labelColor: const Color(0xFF5B21B6),
                valueColor: const Color(0xFF0F172A),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillPill extends StatelessWidget {
  final String label;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;

  const _SkillPill({
    required this.label,
    required this.fillColor,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.22),
            blurRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.audiowide(
          color: textColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 0.35,
        ),
      ),
    );
  }
}

/// On web, loads `web/assets/...` over HTTP; elsewhere uses [Image.asset].
class _MemberPhoto extends StatelessWidget {
  final String imagePath;
  final ColorScheme colorScheme;

  const _MemberPhoto({
    required this.imagePath,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person_rounded,
        size: 48,
        color: colorScheme.onSurfaceVariant,
      ),
    );

    // Decode budget in physical px: square side 3× the on-screen diameter (112×dpr) so that
    // "fit inside cacheW×cacheH" still leaves the short edge ≥ 112×dpr for up to ~3:1 aspect photos.
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final decodeSide = (112 * dpr * 3).ceil().clamp(128, 4096);

    if (kIsWeb) {
      return Image.network(
        Uri.base.removeFragment().resolve(imagePath).toString(),
        fit: BoxFit.cover,
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        cacheWidth: decodeSide,
        cacheHeight: decodeSide,
        filterQuality: FilterQuality.high,
        isAntiAlias: true,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) => fallback,
      );
    }

    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      cacheWidth: decodeSide,
      cacheHeight: decodeSide,
      filterQuality: FilterQuality.high,
      isAntiAlias: true,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) => fallback,
    );
  }
}

class _ProfileNavArrow extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _ProfileNavArrow({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: const Color(0xFF8B6914),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shadowColor: Colors.black54,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Icon(icon, size: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color fillColor;
  final Color borderColor;
  final Color labelColor;
  final Color valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.fillColor,
    required this.borderColor,
    required this.labelColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: borderColor.withValues(alpha: 0.28),
              blurRadius: 0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: Icon(icon, size: 24, color: labelColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: labelColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.35,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        height: 1.35,
                        color: valueColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String country;
  final String role;
  final String hobbies;
  final String motto;
  final String imagePath;

  const TeamMember({
    required this.name,
    required this.country,
    required this.role,
    required this.hobbies,
    required this.motto,
    required this.imagePath,
  });
}

