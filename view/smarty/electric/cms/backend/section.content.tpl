{include file="cms/backend/content.prototype"}
{include file=$layout->getBackendResource()}

{call sectionPanel site=$site node=$node section=$section layouts=$layouts layout=$layout->getName() widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}
