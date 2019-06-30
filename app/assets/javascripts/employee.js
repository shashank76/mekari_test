$( document ).ready(function() {
    $("#csv_file").change(function(){
    if ($("#csv_file").val().split(".")[1] != "csv"){
      alert("Invalid file type.");
      $("#csv_file").val("");
    }
  });
});
