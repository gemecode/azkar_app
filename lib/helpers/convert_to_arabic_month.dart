String converttoarabicmonth(String number) {
  String month;
  switch (number) {
    case '01' || '1':
      month = 'يناير';
      break;
    case '02' || '2':
      month = 'فبراير';
      break;
    case '03' || '3':
      month = 'مارس';
      break;
    case '04' || '4':
      month = 'إبريل';
      break;
    case '05' || '5':
      month = 'مايو';
      break;
    case '06' || '6':
      month = 'يونيو';
      break;
    case '07' || '7':
      month = 'يوليو';
      break;
    case '08' || '8':
      month = 'أغسطس';
      break;
    case '09' || '9':
      month = 'سبتمبر';
      break;
    case '10':
      month = 'أُكتوبر';
      break;
    case '11':
      month = 'نوفمبر';
      break;
    case '12':
      month = 'ديسمبر';
      break;

    default:
      month = number;
  }
  return month;
}
