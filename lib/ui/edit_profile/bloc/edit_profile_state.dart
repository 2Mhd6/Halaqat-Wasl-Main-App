part of 'edit_profile_bloc.dart';

@immutable
//states
class EditProfileState {
  final bool isSaved;
  final bool currentPasswordObscureText;
  final bool newPasswordObscureText;
  final bool confirmNewPasswordObscureText;
  final bool isLoading;
  final String? errorMessage;
  const EditProfileState({
    this.errorMessage,
    this.isSaved = false,
    this.currentPasswordObscureText = true,
    this.newPasswordObscureText = true,
    this.confirmNewPasswordObscureText = true,
    this.isLoading = false,
  });


  //CopyWith: Returns a new copy of the state with updated values
  EditProfileState copyWith({
    bool? isSaved,
    bool? currentPasswordObscureText,
    bool? newPasswordObscureText,
    bool? confirmNewPasswordObscureText,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EditProfileState(
      isSaved: isSaved ?? this.isSaved,
      currentPasswordObscureText:
          currentPasswordObscureText ?? this.currentPasswordObscureText,
      newPasswordObscureText:
          newPasswordObscureText ?? this.newPasswordObscureText,
      confirmNewPasswordObscureText:
          confirmNewPasswordObscureText ?? this.confirmNewPasswordObscureText,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }


 // This method compares two objects of the same type based on their property values,
  // to determine if they represent the same state or not.
  // This is important to avoid unnecessary UI rebuilds when the state hasn't changed.
  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditProfileState &&
        other.isSaved == isSaved &&
        other.currentPasswordObscureText == currentPasswordObscureText &&
        other.newPasswordObscureText == newPasswordObscureText &&
        other.confirmNewPasswordObscureText == confirmNewPasswordObscureText &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }


 // This method returns a unique hash code for each state based on its property values,
  @override
  int get hashCode =>
      isSaved.hashCode ^
      currentPasswordObscureText.hashCode ^
      newPasswordObscureText.hashCode ^
      confirmNewPasswordObscureText.hashCode ^
      isLoading.hashCode ^
      (errorMessage?.hashCode ?? 0);
}
