


var webURL=api.originEntity.getLabelValue("webURL").trim();
var embedURL=webURL.replace("watch?v=", "embed/");

document.getElementById('content').innerHTML=document.getElementById('content').innerHTML.replace("$$PLACEHOLDER$$", embedURL);
