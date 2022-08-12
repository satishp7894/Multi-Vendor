class ChangePasswordRequest {
  const ChangePasswordRequest(this.currentPassword, this.newPassword, this.confirmPasswod);
  final String currentPassword;
  final String newPassword;
  final String confirmPasswod;
}
