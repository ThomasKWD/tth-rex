<?php
  if (rex::isBackend()):
	  echo markitup::parseOutput ('markdown', 'REX_VALUE[id=1 output="html"]');
?>
<!-- <p><em>(Diese Notiz ist im Frontend niemals zu sehen.)</em></p> -->
<?php endif;?>