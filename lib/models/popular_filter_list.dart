class FilterListData {
  FilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<FilterListData> parroquiasList = <FilterListData>[
    FilterListData(
      titleTxt: 'El_Cisne',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Taquil',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Chantaco',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Gualel',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Chuquiribamba',
      isSelected: false,
    ),
  ];

  static List<FilterListData> accomodationList = [
    FilterListData(
      titleTxt: 'All',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Apartment',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Home',
      isSelected: true,
    ),
    FilterListData(
      titleTxt: 'Villa',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Hotel',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Resort',
      isSelected: false,
    ),
  ];
}
