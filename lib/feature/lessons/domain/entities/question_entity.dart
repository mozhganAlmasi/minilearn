class QuestionEntity {
  final String? question;
  final List<String>? choices;
  final int? answerIndex;

  const QuestionEntity({
    this.question,
    this.choices,
    this.answerIndex,
  });
}
