<?php
/**
 *
 * @package    mahara
 * @subpackage skin
 * @author     Gregor Anzelj
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL version 3 or later
 * @copyright  For copyright information on Mahara, please see the README file distributed with this software.
 * @copyright  (C) 2010-2013 Gregor Anzelj <gregor.anzelj@gmail.com>
 *
 */

define('INTERNAL', 1);
define('MENUITEM', 'myportfolio/skins');
define('SECTION_PLUGINTYPE', 'core');
define('SECTION_PLUGINNAME', 'skin');
define('SECTION_PAGE', 'index');

require(dirname(dirname(__FILE__)) . '/init.php');
require_once('skin.php');
require_once('pieforms/pieform.php');
define('TITLE', get_string('myskins', 'skin'));

if (!can_use_skins()) {
    throw new FeatureNotEnabledException();
}

$filter = param_alpha('filter', 'all');
$limit  = param_integer('limit', 6); // For 2x3 grid, showing thumbnails of view skins (2 rows with 3 thumbs each).
$offset = param_integer('offset', 0);

$data = Skin::get_myskins_data($limit, $offset, $filter);

$form = pieform(array(
    'name'   => 'filter',
    'method' => 'post',
    'renderer' => 'oneline',
    'elements' => array(
        'options' => array(
            'type' => 'select',
            'options' => array(
                'all'     => get_string('allskins', 'skin'),
                'site'     => get_string('siteskins', 'skin'),
                'user'  => get_string('userskins', 'skin'),
                'public'  => get_string('publicskins', 'skin'),
            ),
            'defaultvalue' => $filter
        ),
        'submit' => array(
            'type' => 'submit',
            'value' => get_string('filter')
        )
    ),
));

$pagination = build_pagination(array(
    'url' => get_config('wwwroot') . 'skin/index.php?filter=' . $filter,
    'count' => $data->count,
    'limit' => $limit,
    'offset' => $offset,
    'resultcounttextsingular' => get_string('skin', 'skin'),
    'resultcounttextplural' => get_string('skins', 'skin'),
));

$css = array(
    '<link rel="stylesheet" type="text/css" href="' . get_config('wwwroot') . 'theme/raw/static/style/skin.css">',
);


$smarty = smarty(array(), $css, array(), array());
$smarty->assign('skins', $data->data);
$smarty->assign('user', $USER->get('id'));
$smarty->assign('form', $form);
$smarty->assign('filter', $filter);
$smarty->assign('pagination', $pagination['html']);
$smarty->assign('PAGEHEADING', hsc(TITLE));
$smarty->display('skin/index.tpl');

function filter_submit(Pieform $form, $values) {
    redirect('/skin/index.php?filter=' . $values['options']);
}