mixin InputValidator {
  static bool isTitleValid(title) => title.length > 0;
  static bool isDescriptionValid(Desc) => Desc.length > 0;
  static bool isCodeValid(Code) => Code.length > 0;
  static bool isPriceValid(Price) => Price.length > 0;
  static bool isRatingValid(Rating) => Rating.length > 0;
  static bool isAuthorValid(Author) => Author.length > 0;
  static bool isAuthorBiography(biography) => biography.length > 0;
  bool isFormValid(title, desc, code, price, rating, author) {
    if (title.length > 0 &&
        desc.length > 0 &&
        code.length > 0 &&
        price.length > 0 &&
        rating.length > 0 &&
        author.length > 0) {
      return true;
    } else {
      return false;
    }
  }
}
