    function settings($key = null, $default = null)
    {
        try {
            if (is_null($key)) {
                return app('anlutro\LaravelSettings\SettingStore');
            }

            return app('anlutro\LaravelSettings\SettingStore')->get($key, $default);
        } catch (\Throwable $e) {
            return $default;
        }
    }
