{url id="profile.password.reset" parameters=["user" => $encryptedUsername, "time" => $encryptedTime] var="url"}

<p>Hello {$user->getDisplayName()},</p>

<p>You have requested to reset your password. Please click on the link below to change your password:<br />
<a href="{$url}">{$url}</a></p>
