/**
 * DashboardLinks 3.1 
 *
 * Dashboard Links widget plugin for Evolution CMS
 * @author    Nicola Lambathakis
 * @category    plugin
 * @version    3.1 rc
 * @license	   http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnManagerWelcomeHome,OnManagerMainFrameHeaderHTMLBlock
 * @internal    @installset base
 * @internal    @modx_category Dashboard
 * @author      Nicola Lambathakis http://www.tattoocms.it/
 * @documentation Requirements: This plugin requires Evolution 1.3.1 or later
 * @reportissues https://github.com/Nicola1971/WelcomeStats-EvoDashboard-Plugin/issues
 * @link        
 * @lastupdate  30/08/2017
 * @internal    @properties &wdgVisibility=Show widget for:;menu;All,AdminOnly;show &wdgTitle= Stats widget Title:;string;Shortcuts  &wdgicon= widget icon:;string;fa-link  &wdgposition=widget position:;list;1,2,3,4,5,6,7,8,9,10;1 &wdgsizex=widget x size:;list;12,6,4,3;12 &WidgetChunk= Widget chunk:;string;Dashboard_CustomLinks
*/
// get manager role
$role = $_SESSION['mgrRole'];          
if(($role!=1) AND ($wdgVisibility == 'AdminOnly')) {}
else {
// get language
global $modx,$_lang;
// get plugin id
$result = $modx->db->select('id', $this->getFullTableName("site_plugins"), "name='{$modx->event->activePlugin}' AND disabled=0");
$pluginid = $modx->db->getValue($result);
if($modx->hasPermission('edit_plugin')) {
$button_pl_config = '<a data-toggle="tooltip" title="' . $_lang["settings_config"] . '" href="index.php?id='.$pluginid.'&a=102" class="text-muted pull-right" ><i class="fa fa-cog"></i> </a>';
}
$modx->setPlaceholder('button_pl_config', $button_pl_config);
/*Widget Box */

$WidgetOutput = ''.$modx->getChunk(''.$WidgetChunk.'').'';

$e = &$modx->Event;
switch($e->name){
/*load styles with OnManagerMainFrameHeaderHTMLBlock*/
case 'OnManagerMainFrameHeaderHTMLBlock':
$cssOutput = '<link type="text/css" rel="stylesheet" href="../assets/plugins/dashboardlinks/css/colors.css">';
$e->output($cssOutput);
break;
case 'OnManagerWelcomeHome':
			$widgets['DashboardLinks'] = array(
				'menuindex' =>''.$wdgposition.'',
				'id' => 'DashboardLinks'.$pluginid.'',
				'cols' => 'col-md-'.$wdgsizex.'',
				'icon' => ''.$wdgicon.'',
				'title' => ''.$wdgTitle.' '.$button_pl_config.'',
				'body' => '<div class="card-body">'.$WidgetOutput.' </div>',
				'hide' => '0'
			);	
            $e->output(serialize($widgets));
    break;
}
}