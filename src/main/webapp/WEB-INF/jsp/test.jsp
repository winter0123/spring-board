<script>
function findAnagram(input, target) {
  var result = [];
  var length = input.length
    , sortedInput = input.split("").sort(function(a, b) {
      return a.localeCompare(b);
    });
  
  for (var i = 0, li = target.length; i < li - length; i++) {
    var substr = target.substr(0, length);
    var sortedSubStr = substr.split("").sort(function(a, b) {
      return a.localeCompare(b);
    });

    if (sortedSubStr == sortedInput) {
      result.push(i);
    }
  }

  return result;
}
</script>