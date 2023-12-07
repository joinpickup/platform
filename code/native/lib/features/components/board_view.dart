import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/features/home_screen.dart';

class BoardFeed extends StatelessWidget {
  const BoardFeed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 200,
            decoration: ShapeDecoration(
              color: fColorCardBlue,
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 24,
                  cornerSmoothing: 0.6,
                ),
              ),
            ),
            padding: const EdgeInsets.all(16),
            // left and right
            child: Row(
              children: [
                // side bar
                Container(
                  width: 8,
                  decoration: const BoxDecoration(
                    color: fColorCardBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                // body
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // title
                    const BoardHeader(),
                    // description
                    const SizedBox(
                      width: 16,
                    ),
                    // data
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "5d ago",
                          style: TextStyle(
                            color: fColorRoyal,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.string(
                              '''
                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6">
                        <path d="M5.625 1.5c-1.036 0-1.875.84-1.875 1.875v17.25c0 1.035.84 1.875 1.875 1.875h12.75c1.035 0 1.875-.84 1.875-1.875V12.75A3.75 3.75 0 0016.5 9h-1.875a1.875 1.875 0 01-1.875-1.875V5.25A3.75 3.75 0 009 1.5H5.625z" />
                        <path d="M12.971 1.816A5.23 5.23 0 0114.25 5.25v1.875c0 .207.168.375.375.375H16.5a5.23 5.23 0 013.434 1.279 9.768 9.768 0 00-6.963-6.963z" />
                      </svg>
                    
                            ''',
                              width: 24,
                              height: 24,
                              theme: const SvgTheme(
                                currentColor: fColorRoyal,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              "2k",
                              style: TextStyle(
                                color: fColorRoyal,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SvgPicture.string(
                              '''
                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6">
                        <path fill-rule="evenodd" d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z" clip-rule="evenodd" />
                      </svg>
                            ''',
                              width: 24,
                              height: 24,
                              theme: const SvgTheme(
                                currentColor: fColorRoyal,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              "100k",
                              style: TextStyle(
                                color: fColorRoyal,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BoardHeader extends StatelessWidget {
  const BoardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "@local-hq",
          style: TextStyle(
            color: fColorRoyal,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          "/",
          style: TextStyle(
            color: fColorRoyal,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          "Nearby",
          style: TextStyle(
            color: fColorRoyal,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
