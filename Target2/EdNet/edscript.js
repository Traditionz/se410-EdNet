function showTab(tabName) {
  var i, tabcontent;

  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  document.getElementById(tabName).style.display = "block";
}

function clickInner(pageName) {
    window.location.href = pageName;
}


function toggleFilter(dropDown) {
  document.getElementById(dropDown).classList.toggle("show");
}