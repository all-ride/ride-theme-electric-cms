<?php

namespace ride\web\cms\node;

use ride\library\cms\node\Node;
use ride\library\cms\node\NodeModel;
use ride\library\cms\node\SiteNode;
use ride\library\i18n\translator\Translator;
use ride\library\security\SecurityManager;
use ride\library\StringHelper;

use ride\web\cms\controller\backend\TreeController;
use ride\web\WebApplication;

class ElectricNodeTreeGenerator implements NodeTreeGenerator {

    public function __construct(WebApplication $web, NodeModel $nodeModel, SecurityManager $securityManager, Translator $translator, array $actions) {
        $this->web = $web;
        $this->nodeModel = $nodeModel;
        $this->nodeTypeManager = $this->nodeModel->getNodeTypeManager();
        $this->securityManager = $securityManager;
        $this->translator = $translator;
        $this->actions = $actions;
    }

    /**
     * Renders the HTML for the node tree
     * @return string
     */
    public function getTreeHtml(Node $node, $locale) {
        if ($node->getId()) {
            $this->rootNodeId = $node->getRootNodeId();
        } else {
            $parentNode = $node->getParentNode();
            if ($parentNode) {
                $this->rootNodeId = $parentNode->getRootNodeId();
            } else {
                return;
            }
        }

        $this->readToggledNodes();

        $this->node = $node;
        $this->locale = $locale;
        $this->referer = '?referer=' . urlencode($this->web->getRequest()->getUrl());

        $site = $this->nodeModel->getNode($this->rootNodeId, null, true);
        $addUnlocalizedClass = $site->getLocalizationMethod() == SiteNode::LOCALIZATION_METHOD_COPY;

        $html = '<ul id="node-tree">';
        $html .= $this->getNodeHtml($site, $addUnlocalizedClass);
        $html .= '</ul>';

        return $html;
    }

    /**
     * Reads the toggled nodes from the user and/or session
     * @return null
     */
    protected function readToggledNodes() {
        $user = $this->securityManager->getUser();
        if ($user) {
            $nodes = $user->getPreference(TreeController::SESSION_TOGGLED_NODES, array());
        } else {
            $nodes = array();
        }

        $request = $this->web->getRequest();
        if ($request->hasSession()) {
            $this->toggledNodes = $request->getSession()->get(TreeController::SESSION_TOGGLED_NODES, $nodes);
        } else {
            $this->toggleNodes = $nodes;
        }
    }

    /**
     * Get the HTML of a node
     * @param joppa\model\Node $node the node to render
     * @param int $defaultNodeId id of the node of the default page
     * @param joppa\model\Node $selectedNode the current node in the ui
     * @param boolean $addUnlocalizedClass Set to true to add the unlocalized class to nodes which are not localized in the current locale
     * @param int $truncateSize number of characters to truncate the name to
     * @return string HTML representation of the node
     */
    private function getNodeHtml(Node $node, $addUnlocalizedClass, $truncateSize = 20) {
        $id = $node->getId();
        $name = $node->getName($this->locale);
        $type = $node->getType();
        $nodeType = $this->nodeTypeManager->getNodeType($type);
        $urlVars = array(
            'site' => $this->rootNodeId,
            'node' => $id,
            'locale' => $this->locale,
        );

        // checks if this node is selected
        $isNodeSelected = false;
        if ($this->node->getId() == $id) {
            $isNodeSelected = true;
        }

        // generate the node css class
        $nodeClass = 'node';
        $nodeClass .= ' node-' . $type;
        if ($isNodeSelected) {
            $nodeClass .= ' selected';
        }
        if ($addUnlocalizedClass) {
            $localizedName = $node->getProperty(Node::PROPERTY_NAME . '.' . $this->locale);
            if ($localizedName) {
                $nodeClass .= ' localized';
            } else {
                $nodeClass .= ' unlocalized';
            }
        }

        // set the previous collapse state
        if (isset($this->toggledNodes[$id])) {
            $nodeClass .= ' closed';
        }

        $html = '<li class="' . $nodeClass . '" id="node-' . $id . '">';

        $nodeIconTypeMap = array(
            'site' => 'globe',
            'page' => 'file-o',
            'folder' => 'folder-open-o',
            'entry' => 'hdd-o',
            'redirect' => 'share-square-o',
        );

        // add icon state classes
        if ($nodeType->getFrontendCallback()) {
            $nodeClass = $nodeIconTypeMap[$type];

            if ($node->getRoute($this->locale) == '/') {
                $nodeClass = 'home';
            }

            if (!$node->isPublished()) {
                $nodeClass = 'eye-slash';
            }
        } else {
            $nodeClass = $nodeIconTypeMap[$type];
        }

        $children = $node->getChildren();
        if ($children) {
            if (isset($this->toggledNodes[$id])) {
                $html .= '<a href="#" class="toggle"><i class="icon icon--plus-square-o"></i></a>';
            } else {
                $html .= '<a href="#" class="toggle"><i class="icon icon--minus-square-o"></i></a>';
            }
        } else {
            $html .= '<span class="toggle"></span>';
        }

        $html .= '<div class="handle"><i class="icon icon--' . $nodeClass . '"></i></div>';
        $html .= '<div class="dropdown">';

        $truncatedName = StringHelper::truncate($name, $truncateSize, '...', true, true);

        $html .= $this->getAnchorHtml($this->web->getUrl('cms.node.default', $urlVars) . $this->referer, $truncatedName, false, 'name', null, $name);
        //         $html .= $this->getAnchorHtml('#', ' ', false, 'action-menu-node', 'node-actions-' . $id);
        $html .= $this->getAnchorHtml('#', '<i class="icon icon--angle-down"></i>', false, 'dropdown-toggle', 'node-actions-' . $id);
        $html .= '<ul class="dropdown__menu" id="node-actions-' . $id . '-menu" role="menu">';

        foreach ($this->actions as $actionName => $action) {
            if (!$action->isAvailableForNode($node)) {
                continue;
            }

            $actionUrl = $this->web->getUrl($action->getRoute(), $urlVars) . $this->referer;
            if (!$this->securityManager->isUrlAllowed($actionUrl)) {
                continue;
            }

            $html .= '<li>';
            $html .= $this->getAnchorHtml($actionUrl, 'label.node.action.' . $actionName, true, $actionName);
            $html .= '</li>';
        }

        $actions = array();

        $actionUrl = $this->web->getUrl($nodeType->getRouteEdit(), $urlVars) . $this->referer;
        if ($this->securityManager->isUrlAllowed($actionUrl)) {
            $actions[] = $this->getAnchorHtml($actionUrl, 'label.node.action.edit', true, 'edit');
        }

        $actionUrl = $this->web->getUrl($nodeType->getRouteClone(), $urlVars) . $this->referer;
        if ($this->securityManager->isUrlAllowed($actionUrl)) {
            $actions[] = $this->getAnchorHtml($actionUrl, 'button.clone', true, 'clone method-post');
        }

        $actionUrl = $this->web->getUrl($nodeType->getRouteDelete(), $urlVars) . $this->referer;
        if ($this->securityManager->isUrlAllowed($actionUrl)) {
            $actions[] = $this->getAnchorHtml($actionUrl, 'button.delete', true, 'delete method-post use-confirm');
        }

        if ($actions) {
            $html .= '<li class="dropdown__divider"></li>';
            foreach ($actions as $action) {
                $html .= '<li>' . $action . '</li>';
            }
        }

        $html .= '</ul>';
        $html .= '</div>';

        if ($children) {
            $html .= '<ul class="children">';
            foreach ($children as $child) {
                $html .= $this->getNodeHtml($child, $addUnlocalizedClass, $truncateSize - 1);
            }
            $html .= '</ul>';
        }

        $html .= '</li>';

        return $html;
    }

    /**
     * Get the html for an anchor
     * @param string $href the href of the anchor
     * @param string $label the label for the anchor
     * @param boolean $translate true to translate the label
     * @param string $class Style class for the anchor
     * @return string html of the anchor
     */
    private function getAnchorHtml($href, $label, $translate, $class = null, $id = null, $title = null) {
        if ($translate) {
            $label = $this->translator->translate($label);
        }

        if (!$label) {
            $label = 'N/A';
        }

        $html = '<a href="' . $href . '"';
        if ($id) {
            $html .= ' id="' . $id . '"';
        }
        if ($class) {
            $html .= ' class="' . $class . '"';

            if ($class == "dropdown-toggle") {
                $html .= ' data-toggle="dropdown"';
            }
        }
        if ($title) {
            $html .= ' title="' . $title . '"';
        }

        return $html . '>' . $label . '</a>';
    }

}
