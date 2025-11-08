
String getServiceIconPath(String label) {
  final key = label.trim().toLowerCase();
  const icons = {
    'wifi': 'assets/icons/wifi.svg',
    'whiteboard': 'assets/icons/whiteboard.svg',
    'power backup': 'assets/icons/power_backup.svg',
    'powerbackup': 'assets/icons/power_backup.svg',
    'a/c': 'assets/icons/ac.svg',
    'ac': 'assets/icons/ac.svg',
    'call': 'assets/icons/phone.svg',
  };
  return icons[key] ?? '';
}