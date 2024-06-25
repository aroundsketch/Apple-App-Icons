$(document).ready(function () {
  $.ajax({
      url: "https://api.github.com/repos/aroundsketch/aroundsketch.github.io/commits",
      jsonp: "callback",
      dataType: "jsonp",
      data: {
          format: "json"
      },
      success: function (response) {
          if (response.data.length > 0) {
              // console.log(response.data[0].commit.author); 
              var lastCommitDate = response.data[0].commit.author.date;
              // console.log(lastCommitDate);
              var lastCommitDateFormat = lastCommitDate.slice(0, 10);
              // console.log(lastCommitDateFormat);
              $('#commitDate').html(lastCommitDateFormat + ".");
          }
      }
  });
});