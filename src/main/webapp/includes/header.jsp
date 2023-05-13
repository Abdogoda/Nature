<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="assets/img/favicon.png" type="image/png" />
<link rel="stylesheet" href="assets/css/nature.css" />
<link href="assets/css/all.min.css" rel="stylesheet">
<link href="assets/css/alert.css" rel="stylesheet">
<script src="assets/js/alert.js" defer></script>
<script>function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>')}</script>
<style>
.notifications {
 top: 2rem;
 right: 3rem;
 width: 25rem;
 max-width: calc(100% -5rem) !important;
}
.notifications .toast .column i {
 font-size: 2rem;
}
.notifications .toast .column .text span {
 font-size: 1.5rem;
}
.notifications .toast .column .text p {
 font-size: 1.3rem;
}
@media (max-width: 500px) {
 .notifications {
 font-size: 50%;
 }
}

</style>