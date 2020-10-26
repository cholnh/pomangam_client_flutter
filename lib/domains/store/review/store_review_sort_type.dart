enum StoreReviewSortType {
  SORT_BY_DATE_DESC,
  SORT_BY_DATE_ASC,
  SORT_BY_STAR_DESC,
  SORT_BY_STAR_ASC,
}

StoreReviewSortType convertTextToSortType(String type) {
  if(type == null) return null;
  return StoreReviewSortType.values.singleWhere((value) => value.toString().toUpperCase() == type.toUpperCase());
}

String convertStoreReviewSortTypeToText(StoreReviewSortType type) {
  if(type != null) {
    switch(type) {
      case StoreReviewSortType.SORT_BY_STAR_DESC:
        return '별점높은순';
      case StoreReviewSortType.SORT_BY_STAR_ASC:
        return '별점낮은순';
      case StoreReviewSortType.SORT_BY_DATE_DESC:
        return '최신날짜순';
      case StoreReviewSortType.SORT_BY_DATE_ASC:
        return '오랜날짜순';
    }
  }
  return '';
}