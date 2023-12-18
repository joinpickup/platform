part of 'visibility_selector_cubit.dart';

enum VisibilityOption {
  public(icon: kIconEye, text: "Public"),
  private(icon: kIconEyeClose, text: "Private");

  final String icon;
  final String text;

  const VisibilityOption({required this.icon, required this.text});
}
