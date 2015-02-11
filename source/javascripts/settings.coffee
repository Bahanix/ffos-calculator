$vibration = document.getElementById("vibration")
$vibration.checked = localStorage.getItem("vibration") == "true"
$vibration.onchange = ->
  localStorage.setItem "vibration", this.checked
