enum TaskFilterEnum {
  today,
  tomorrow,
  week,
}

extension TaskFilterDescription on TaskFilterEnum {
  String get description {
    switch (this) {
      case TaskFilterEnum.today:
        return 'de hoje';
      case TaskFilterEnum.tomorrow:
        return 'de amanhã';
      case TaskFilterEnum.week:
        return 'da semana';
    }
  }
}
