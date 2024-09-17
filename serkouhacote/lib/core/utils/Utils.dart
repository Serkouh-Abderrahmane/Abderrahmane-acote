// Capitalizes the first letter of a string.
// 문자열의 첫 글자를 대문자로 변환합니다.
String capitalize(String s) {
  // Ensure string is not empty to avoid errors.
  // 문자열이 비어 있지 않은지 확인합니다.
  if (s.isEmpty) return s;

  // Capitalize the first letter and concatenate with the rest of the string.
  // 첫 글자를 대문자로 변환하고 나머지 문자열과 결합합니다.
  return s[0].toUpperCase() + s.substring(1);
}
