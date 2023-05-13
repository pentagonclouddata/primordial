local ffi = require "ffi"
ffi.cdef [[
    typedef int BOOL;
    typedef long LONG;
    typedef unsigned long HWND;
    typedef struct{
        LONG x, y;
    }POINT, *LPPOINT;

    typedef unsigned long DWORD, *PDWORD, *LPDWORD;

    typedef struct _SECURITY_ATTRIBUTES {
        DWORD  nLength;
        void* lpSecurityDescriptor;
        BOOL   bInheritHandle;
    } SECURITY_ATTRIBUTES, *PSECURITY_ATTRIBUTES, *LPSECURITY_ATTRIBUTES;

    short GetAsyncKeyState(int vKey);
    bool DeleteFileA(
       const char* lpFileName
     );

    unsigned long GetFileSize(
         void*  hFile,
         unsigned long* lpFileSizeHigh
    );
    bool DeleteUrlCacheEntryA(const char* lpszUrlName);
    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);
    bool CreateDirectoryA(
         const char*                lpPathName,
         void* lpSecurityAttributes
    );
    void* CloseHandle(void *hFile);
    typedef int(__fastcall* clantag_t)(const char*, const char*);
    void * FindFirstFileA(
        const char*             lpFileName,
        void * lpFindFileData
    );
    bool FindNextFileA(
        void *             hFindFile,
        void * lpFindFileData
    );
    typedef void* HANDLE;
    typedef HANDLE HWND;
    typedef const char* LPCSTR;
    typedef unsigned UINT;
    int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT);
    enum{
        MB_OK = 0x00000000L,
        MB_ICONINFORMATION = 0x00000040L
    };
    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
    typedef struct {

        uint8_t r;
        uint8_t g;
        uint8_t b;
        uint8_t a;
    } color_struct_t;
    typedef struct {
        void*   fnHandle;
        char    szName[260];
        int     nLoadFlags;
        int     nServerCount;
        int     type;
        int     flags;
        float  vecMins[3];
        float  vecMaxs[3];
        float   radius;
        char    pad[0x1C];
    } model_t;
    typedef void (*console_color_print)(const color_struct_t&, const char*, ...);
    typedef int(__thiscall* get_model_index_t)(void*, const char*);
    typedef const model_t(__thiscall* find_or_load_model_t)(void*, const char*);
    typedef int(__thiscall* add_string_t)(void*, bool, const char*, int, const void*);
    typedef void*(__thiscall* find_table_t)(void*, const char*);
    typedef void(__thiscall* set_model_index_t)(void*, int);
    typedef int(__thiscall* precache_model_t)(void*, const char*, bool);
    typedef void*(__thiscall* get_client_entity_t)(void*, int);
    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);

    typedef struct
    {
        float x;
        float y;
        float z;
    } Vector_t;

    typedef struct
    {
        char        pad0[0x60]; // 0x00
        void*       pEntity; // 0x60
        void*       pActiveWeapon; // 0x64
        void*       pLastActiveWeapon; // 0x68
        float        flLastUpdateTime; // 0x6C
        int            iLastUpdateFrame; // 0x70
        float        flLastUpdateIncrement; // 0x74
        float        flEyeYaw; // 0x78
        float        flEyePitch; // 0x7C
        float        flGoalFeetYaw; // 0x80
        float        flLastFeetYaw; // 0x84
        float        flMoveYaw; // 0x88
        float        flLastMoveYaw; // 0x8C // changes when moving/jumping/hitting ground
        float        flLeanAmount; // 0x90
        char        pad1[0x4]; // 0x94
        float        flFeetCycle; // 0x98 0 to 1
        float        flMoveWeight; // 0x9C 0 to 1
        float        flMoveWeightSmoothed; // 0xA0
        float        flDuckAmount; // 0xA4
        float        flHitGroundCycle; // 0xA8
        float        flRecrouchWeight; // 0xAC
        Vector_t    vecOrigin; // 0xB0
        Vector_t    vecLastOrigin;// 0xBC
        Vector_t    vecVelocity; // 0xC8
        Vector_t    vecVelocityNormalized; // 0xD4
        Vector_t    vecVelocityNormalizedNonZero; // 0xE0
        float        flVelocityLenght2D; // 0xEC
        float        flJumpFallVelocity; // 0xF0
        float        flSpeedNormalized; // 0xF4 // clamped velocity from 0 to 1
        float        flRunningSpeed; // 0xF8
        float        flDuckingSpeed; // 0xFC
        float        flDurationMoving; // 0x100
        float        flDurationStill; // 0x104
        bool        bOnGround; // 0x108
        bool        bHitGroundAnimation; // 0x109
        char        pad2[0x2]; // 0x10A
        float        flNextLowerBodyYawUpdateTime; // 0x10C
        float        flDurationInAir; // 0x110
        float        flLeftGroundHeight; // 0x114
        float        flHitGroundWeight; // 0x118 // from 0 to 1, is 1 when standing
        float        flWalkToRunTransition; // 0x11C // from 0 to 1, doesnt change when walking or crouching, only running
        char        pad3[0x4]; // 0x120
        float        flAffectedFraction; // 0x124 // affected while jumping and running, or when just jumping, 0 to 1
        char        pad4[0x208]; // 0x128
        float        flMinBodyYaw; // 0x330
        float        flMaxBodyYaw; // 0x334
        float        flMinPitch; //0x338
        float        flMaxPitch; // 0x33C
        int            iAnimsetVersion; // 0x340
    } CCSGOPlayerAnimationState_534535_t;
    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);
    typedef uintptr_t (__thiscall* GetClientEntityHandle_4242425_t)(void*, int);

    struct WeaponInfo_t
    {
        char* consoleName;                // 0x0004
        char        pad_0008 [ 8 ];                // 0x0008
        void* m_pWeaponDef;  //0x0010
        int            iMaxClip1;                    // 0x0014
        int            iMaxClip2;                    // 0x0018
        int            iDefaultClip1;                // 0x001C
        int            iDefaultClip2;                // 0x0020
        char        pad_0024 [ 8 ];                // 0x0024
        char* szWorldModel;                // 0x002C
        char* szViewModel;                // 0x0030
        char* szDroppedModel;                // 0x0034
        char        pad_0038 [ 4 ];                // 0x0038
        char* N0000023E;                    // 0x003C
        char        pad_0040 [ 56 ];                // 0x0040
        char* szEmptySound;                // 0x0078
        char        pad_007C [ 4 ];                // 0x007C
        char* szBulletType;                // 0x0080
        char        pad_0084 [ 4 ];                // 0x0084
        char* szHudName;                    // 0x0088
        char* szWeaponName;                // 0x008C
        char        pad_0090 [ 60 ];                // 0x0090
        int         WeaponType;                    // 0x00C8
        int            iWeaponPrice;                // 0x00CC
        int            iKillAward;                    // 0x00D0
        char* szAnimationPrefix;            // 0x00D4
        float        flCycleTime;                // 0x00D8
        float        flCycleTimeAlt;                // 0x00DC
        float        flTimeToIdle;                // 0x00E0
        float        flIdleInterval;                // 0x00E4
        bool        bFullAuto;                    // 0x00E8
        char        pad_0x00E5 [ 3 ];            // 0x00E9
        int            iDamage;                    // 0x00EC
        float        flArmorRatio;                // 0x00F0
        int            iBullets;                    // 0x00F4
        float        flPenetration;                // 0x00F8
        float        flFlinchVelocityModifierLarge;    // 0x00FC
        float        flFlinchVelocityModifierSmall;    // 0x0100
        float        flRange;                    // 0x0104
        float        flRangeModifier;            // 0x0108
        float        flThrowVelocity;            // 0x010C
        char        pad_0x010C [ 16 ];            // 0x0110
        bool        bHasSilencer;                // 0x011C
        char        pad_0x0119 [ 3 ];            // 0x011D
        char*       pSilencerModel;                // 0x0120
        int            iCrosshairMinDistance;        // 0x0124
        float        flMaxPlayerSpeed;            // 0x0128
        float        flMaxPlayerSpeedAlt;        // 0x012C
        char        pad_0x0130 [ 4 ];            // 0x0130
        float        flSpread;                    // 0x0134
        float        flSpreadAlt;                // 0x0138
        float        flInaccuracyCrouch;            // 0x013C
        float        flInaccuracyCrouchAlt;        // 0x0140
        float        flInaccuracyStand;            // 0x0144
        float        flInaccuracyStandAlt;        // 0x0148
        float        flInaccuracyJumpInitial;    // 0x014C
        float        flInaccuracyJump;            // 0x0150
        float        flInaccuracyJumpAlt;        // 0x0154
        float        flInaccuracyLand;            // 0x0158
        float        flInaccuracyLandAlt;        // 0x015C
        float        flInaccuracyLadder;            // 0x0160
        float        flInaccuracyLadderAlt;        // 0x0164
        float        flInaccuracyFire;            // 0x0168
        float        flInaccuracyFireAlt;        // 0x016C
        float        flInaccuracyMove;            // 0x0170
        float        flInaccuracyMoveAlt;        // 0x0174
        float        flInaccuracyReload;            // 0x0178
        int            iRecoilSeed;                // 0x017C
        float        flRecoilAngle;                // 0x0180
        float        flRecoilAngleAlt;            // 0x0184
        float        flRecoilAngleVariance;        // 0x0188
        float        flRecoilAngleVarianceAlt;    // 0x018C
        float        flRecoilMagnitude;            // 0x0190
        float        flRecoilMagnitudeAlt;        // 0x0194
        float        flRecoilMagnitudeVariance;    // 0x0198
        float        flRecoilMagnitudeVarianceAlt;    // 0x019C
        float        flRecoveryTimeCrouch;        // 0x01A0
        float        flRecoveryTimeStand;        // 0x01A4
        float        flRecoveryTimeCrouchFinal;    // 0x01A8
        float        flRecoveryTimeStandFinal;    // 0x01AC
        int            iRecoveryTransitionStartBullet;    // 0x01B0
        int            iRecoveryTransitionEndBullet;    // 0x01B4
        bool        bUnzoomAfterShot;            // 0x01B8
        bool        bHideViewModelZoomed;        // 0x01B9
        char        pad_0x01B5 [ 2 ];            // 0x01BA
        char        iZoomLevels [ 3 ];            // 0x01BC
        int            iZoomFOV [ 2 ];                // 0x01C0
        float        fZoomTime [ 3 ];                // 0x01C4
        char* szWeaponClass;                // 0x01D4
        float        flAddonScale;                // 0x01D8
        char        pad_0x01DC [ 4 ];            // 0x01DC
        char* szEjectBrassEffect;            // 0x01E0
        char* szTracerEffect;                // 0x01E4
        int            iTracerFrequency;            // 0x01E8
        int            iTracerFrequencyAlt;        // 0x01EC
        char* szMuzzleFlashEffect_1stPerson;    // 0x01F0
        char        pad_0x01F4 [ 4 ];                // 0x01F4
        char* szMuzzleFlashEffect_3rdPerson;    // 0x01F8
        char        pad_0x01FC [ 4 ];            // 0x01FC
        char* szMuzzleSmokeEffect;        // 0x0200
        float        flHeatPerShot;                // 0x0204
        char* szZoomInSound;                // 0x0208
        char* szZoomOutSound;                // 0x020C
        float        flInaccuracyPitchShift;        // 0x0210
        float        flInaccuracySoundThreshold;    // 0x0214
        float        flBotAudibleRange;            // 0x0218
        char        pad_0x0218 [ 8 ];            // 0x0220
        char* pWrongTeamMsg;                // 0x0224
        bool        bHasBurstMode;                // 0x0228
        char        pad_0x0225 [ 3 ];            // 0x0229
        bool        bIsRevolver;                // 0x022C
        bool        bCannotShootUnderwater;        // 0x0230char* hud_name;
        char* weapon_name;
        char _0x0090[60];
    };
    struct sub_WeaponInfo_t
    {
        char _0x0000[20];
        __int32 max_clip;    
        char _0x0018[12];
        __int32 max_reserved_ammo;
        char _0x0028[96];
        char* hud_name;            
        char* weapon_name;        
        char _0x0090[60];
        __int32 type;            
        __int32 price;            
        __int32 reward;            
        char _0x00D8[20];
        bool full_auto;        
        char _0x00ED[3];
        __int32 damage;            
        float armor_ratio;         
        __int32 bullets;    
        float penetration;    
        char _0x0100[8];
        float range;            
        float range_modifier;    
        char _0x0110[16];
        bool silencer;            
        char _0x0121[15];
        float max_speed;        
        float max_speed_alt;
        char _0x0138[76];
        __int32 recoil_seed;
        char _0x0188[32];
    };
    int VirtualProtect(void* lpAddress, unsigned long dwSize, unsigned long flNewProtect, unsigned long* lpflOldProtect);

    typedef struct {
        float x, y, z;
    } vec3_t;

    typedef struct
    {
        int   x;                  //0x0000
        int   x_old;              //0x0004
        int   y;                  //0x0008
        int   y_old;              //0x000C
        int   width;              //0x0010
        int   width_old;          //0x0014
        int   height;             //0x0018
        int   height_old;         //0x001C
        char      pad_0x0020[0x90];   //0x0020
        float     fov;                //0x00B0
        float     viewmodel_fov;      //0x00B4
        vec3_t    origin;             //0x00B8
        vec3_t    angles;             //0x00C4
        char      pad_0x00D0[0x7C];   //0x00D0
    } CViewSetup;

    struct glow_object_definition_t {
        int m_next_free_slot;
        void *m_ent;
        float r;
        float g;
        float b;
        float a;
        bool m_glow_alpha_capped_by_render_alpha;
        float m_glow_alpha_function_of_max_velocity;
        float m_glow_alpha_max;
        float m_glow_pulse_overdrive;
        bool m_render_when_occluded;
        bool m_render_when_unoccluded;
        bool m_full_bloom_render;
        char pad_0;
        int m_full_bloom_stencil_test_value;
        int m_style;
        int split_screen_slot;

        static const int END_OF_FREE_LIST = -1;
        static const int ENTRY_IN_USE = -2;
    };

    struct c_glow_object_mngr {
        struct glow_object_definition_t *m_glow_object_definitions;
        int m_max_size;
        int m_pad;
        int m_size;
        struct glow_object_definition_t *m_glow_object_definitions2;
        int m_current_objects;
    };
    typedef void*(__thiscall* get_client_entity_t)(void*, int);
    typedef int(__thiscall* get_clipboard_text_count)(void*);
    typedef void(__thiscall* get_clipboard_text)(void*, int, const char*, int);
    typedef void(__thiscall* set_clipboard_text)(void*, const char*, int);
]]
local steam_http_raw = ffi.cast("uint32_t**", ffi.cast("char**", ffi.cast("char*", memory.find_pattern("client.dll", "B9 ? ? ? ? E8 ? ? ? ? 83 3D ? ? ? ? ? 0F 84")) + 1)[0] + 48)[0] or error("steam_http error")
local steam_http_ptr = ffi.cast("void***", steam_http_raw) or error("steam_http_ptr error")
local steam_http = steam_http_ptr[0] or error("steam_http_ptr was null")
-- #endregion

--#region helper functions
local function __thiscall(func, this) -- bind wrapper for __thiscall functions
	return function(...)
		return func(this, ...)
	end
end
--#endregion

-- #region native casts
local createHTTPRequest_native = __thiscall(ffi.cast(ffi.typeof("uint32_t(__thiscall*)(void*, uint32_t, const char*)"), steam_http[0]), steam_http_raw)
local sendHTTPRequest_native = __thiscall(ffi.cast(ffi.typeof("bool(__thiscall*)(void*, uint32_t, uint64_t)"), steam_http[5]), steam_http_raw)
local getHTTPResponseHeaderSize_native = __thiscall(ffi.cast(ffi.typeof("bool(__thiscall*)(void*, uint32_t, const char*, uint32_t*)"), steam_http[9]), steam_http_raw)
local getHTTPResponseHeaderValue_native = __thiscall(ffi.cast(ffi.typeof("bool(__thiscall*)(void*, uint32_t, const char*, char*, uint32_t)"), steam_http[10]), steam_http_raw)
local getHTTPResponseBodySize_native = __thiscall(ffi.cast(ffi.typeof("bool(__thiscall*)(void*, uint32_t, uint32_t*)"), steam_http[11]), steam_http_raw)
local getHTTPBodyData_native = __thiscall(ffi.cast(ffi.typeof("bool(__thiscall*)(void*, uint32_t, char*, uint32_t)"), steam_http[12]), steam_http_raw)
local setHTTPHeaderValue_native = __thiscall(ffi.cast(ffi.typeof("bool(__thiscall*)(void*, uint32_t, const char*, const char*)"), steam_http[3]), steam_http_raw)
local setHTTPRequestParam_native = __thiscall(ffi.cast(ffi.typeof("bool(__thiscall*)(void*, uint32_t, const char*, const char*)"), steam_http[4]), steam_http_raw)
local setHTTPUserAgent_native = __thiscall(ffi.cast(ffi.typeof("bool(__thiscall*)(void*, uint32_t, const char*)"), steam_http[21]), steam_http_raw)
local setHTTPRequestRaw_native = __thiscall(ffi.cast("bool(__thiscall*)(void*, uint32_t, const char*, const char*, uint32_t)", steam_http[16]), steam_http_raw)
local releaseHTTPRequest_native = __thiscall(ffi.cast(ffi.typeof("bool(__thiscall*)(void*, uint32_t)"), steam_http[14]), steam_http_raw)
-- #endregion

local requests = {}
callbacks.add(e_callbacks.PAINT, function ()
	for _, instance in ipairs(requests) do
		if global_vars.cur_time() - instance.ls > instance.task_interval then
			instance:_process_tasks()
			instance.ls = global_vars.cur_time()
		end
	end
end)
local request = {}
local request_mt = {__index = request}
function request.new(requestHandle, requestAddress, callbackFunction)
	return setmetatable({handle = requestHandle, url = requestAddress, callback = callbackFunction, ticks = 0}, request_mt)
end
local data = {}
local data_mt = {__index = data}
function data.new(state, body, headers)
	return setmetatable({status = state, body = body, headers = headers}, data_mt)
end
function data:success()
	return self.status == 200
end
local httpFactory = {state = {ok = 200, no_response = 204, timed_out = 408, unknown = 0}}
local http_mt = {__index = httpFactory}
function httpFactory.new(task)
	task = task or {}
	local instance = setmetatable({requests = {}, task_interval = task.task_interval or 0.3, enable_debug = task.debug or false, timeout = task.timeout or 10, ls = global_vars.cur_time()}, http_mt)
	table.insert(requests, instance)
	return instance
end
local method_t = {['get'] = 1, ['head'] = 2, ['post'] = 3, ['put'] = 4, ['delete'] = 5, ['options'] = 6, ['patch'] = 7}
function httpFactory:request(method, url, options, callback)
	if type(options) == "function" and callback == nil then
		callback = options
		options = {}
	end
	options = options or {}
	local method_num = method_t[tostring(method):lower()]
	local reqHandle = createHTTPRequest_native(method_num, url)
	local content_type = "application/text"
	if type(options.headers) == "table" then
		for name, value in pairs(options.headers) do
			name = tostring(name)
			value = tostring(value)
			if name:lower() == "content-type" then
				content_type = value
			end
			setHTTPHeaderValue_native(reqHandle, name, value)
		end
	end
	if type(options.body) == "string" then
		local len = options.body:len()
		setHTTPRequestRaw_native(reqHandle, content_type, ffi.cast("unsigned char*", options.body), len)
	end
	if type(options.params) == "table" then
		for k, v in pairs(options.params) do
			setHTTPRequestParam_native(reqHandle, k, v)
		end
	end
	if type(options.user_agent_info) == "string" then
		setHTTPUserAgent_native(reqHandle, options.user_agent_info)
	end
	if not sendHTTPRequest_native(reqHandle, 0) then
		return
	end
	local reqInstance = request.new(reqHandle, url, callback)
	self:_debug("[HTTP] New %s request to: %s", method:upper(), url)
	table.insert(self.requests, reqInstance)
end
function httpFactory:get(url, callback)
	local reqHandle = createHTTPRequest_native(1, url)
	if not sendHTTPRequest_native(reqHandle, 0) then
		return
	end
	local reqInstance = request.new(reqHandle, url, callback)
	self:_debug("[HTTP] New GET request to: %s", url)
	table.insert(self.requests, reqInstance)
end
function httpFactory:post(url, params, callback)
	local reqHandle = createHTTPRequest_native(3, url)
	for k, v in pairs(params) do
		setHTTPRequestParam_native(reqHandle, k, v)
	end
	if not sendHTTPRequest_native(reqHandle, 0) then
		return
	end
	local reqInstance = request.new(reqHandle, url, callback)
	self:_debug("[HTTP] New POST request to: %s", url)
	table.insert(self.requests, reqInstance)
end
function httpFactory:_process_tasks()
	for k, v in ipairs(self.requests) do
		local data_ptr = ffi.new("uint32_t[1]")
		self:_debug("[HTTP] Processing request #%s", k)
		if getHTTPResponseBodySize_native(v.handle, data_ptr) then
			local reqData = data_ptr[0]
			if reqData > 0 then
				local strBuffer = ffi.new("char[?]", reqData)
				if getHTTPBodyData_native(v.handle, strBuffer, reqData) then
					self:_debug("[HTTP] Request #%s finished. Invoking callback.", k)
					v.callback(data.new(httpFactory.state.ok, ffi.string(strBuffer, reqData), setmetatable({}, {__index = function(tbl, val) return httpFactory._get_header(v, val) end})))
					table.remove(self.requests, k)
					releaseHTTPRequest_native(v.handle)
				end
			else
				v.callback(data.new(httpFactory.state.no_response, nil, {}))
				table.remove(self.requests, k)
				releaseHTTPRequest_native(v.handle)
			end
		end
		local timeoutCheck = v.ticks + 1;
		if timeoutCheck >= self.timeout then
			v.callback(data.new(httpFactory.state.timed_out, nil, {}))
			table.remove(self.requests, k)
			releaseHTTPRequest_native(v.handle)
		else
			v.ticks = timeoutCheck
		end
	end
end
function httpFactory:_debug(...)
	if self.enable_debug then
		client.log(string.format(...))
	end
end
function httpFactory._get_header(reqInstance, query)
	local data_ptr = ffi.new("uint32_t[1]")
	if getHTTPResponseHeaderSize_native(reqInstance.handle, query, data_ptr) then
		local reqData = data_ptr[0]
		local strBuffer = ffi.new("char[?]", reqData)
		if getHTTPResponseHeaderValue_native(reqInstance.handle, query, strBuffer, reqData) then
			return ffi.string(strBuffer, reqData)
		end
	end
	return nil
end
function httpFactory._bind(class, funcName)
	return function(...)
		return class[funcName](class, ...)
	end
end
local ffi_handler = {}
ffi_handler.bind_argument = function(fn, arg)
    return function(...)
        return fn(arg, ...)
    end
end
ffi_handler.interface_type = ffi.typeof("uintptr_t**")
ffi_handler.vgui_system = ffi.cast(ffi_handler.interface_type, memory.create_interface("vgui2.dll", "VGUI_System010"))
ffi_handler.get_clipboard_text_count = ffi_handler.bind_argument(ffi.cast("int(__thiscall*)(void*)", ffi_handler.vgui_system[0][7]), ffi_handler.vgui_system)
ffi_handler.set_clipboard_text_fn = ffi_handler.bind_argument(ffi.cast("void(__thiscall*)(void*, const char*, int)", ffi_handler.vgui_system[0][9]), ffi_handler.vgui_system)
ffi_handler.get_clipboard_text_fn = ffi_handler.bind_argument(ffi.cast("void(__thiscall*)(void*, int, const char*, int)", ffi_handler.vgui_system[0][11]), ffi_handler.vgui_system)
local clipboard = {}
clipboard.set = function(text)
    ffi_handler.set_clipboard_text_fn(text,#text)
end

clipboard.get = function()
    local clipboard_text_length = ffi_handler.get_clipboard_text_count()
    
    if clipboard_text_length > 0 then
        local buffer = ffi.new("char[?]", clipboard_text_length)
        local size = clipboard_text_length * ffi.sizeof("char[?]", clipboard_text_length)
    
        ffi_handler.get_clipboard_text_fn(0, buffer, size )
    
        return ffi.string( buffer, clipboard_text_length-1)
    end

    return ""
end

local base64 = {}
extract = function(v, from, width)
    return bit.band(bit.rshift(v, from), bit.lshift(1, width) - 1)
end
function base64.makeencoder(alphabet)
    local encoder = {}
    local t_alphabet = {}
    for i = 1, #alphabet do
        t_alphabet[i - 1] = alphabet:sub(i, i)
    end
    for b64code, char in pairs(t_alphabet) do
        encoder[b64code] = char:byte()
    end
    return encoder
end
function base64.makedecoder(alphabet)
    local decoder = {}
    for b64code, charcode in pairs(base64.makeencoder(alphabet)) do
        decoder[charcode] = b64code
    end
    return decoder
end
local base64_string = "KmAWpuFBOhdbI1orP2UN5vnSJcxVRgazk97ZfQqL0yHCl84wTj3eYXiD6stEGM+/="
local crypt_string = base64.makeencoder(base64_string)
local decrypt_string = base64.makedecoder(base64_string)
function base64.encode(str)
    str = tostring(str)
    local encoder = crypt_string
    local t, k, n = {}, 1, #str
    local lastn = n % 3
    for i = 1, n - lastn, 3 do
        local a, b, c = str:byte(i, i + 2)
        local v = a * 0x10000 + b * 0x100 + c
        local s
        s = string.char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[extract(v, 6, 6)],
            encoder[extract(v, 0, 6)])
        t[k] = s
        k = k + 1
    end
    if lastn == 2 then
        local a, b = str:byte(n - 1, n)
        local v = a * 0x10000 + b * 0x100
        t[k] = string.char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[extract(v, 6, 6)],
            encoder[64])
    elseif lastn == 1 then
        local v = str:byte(n) * 0x10000
        t[k] = string.char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[64], encoder[64])
    end
    return table.concat(t)
end
function base64.decode(b64)
    local decoder = decrypt_string
    local pattern = "[^%w%+%/%=]"
    if decoder then
        local s62, s63
        for charcode, b64code in pairs(decoder) do
            if b64code == 62 then
                s62 = charcode
            elseif b64code == 63 then
                s63 = charcode
            end
        end
        pattern = ("[^%%w%%%s%%%s%%=]"):format(string.char(s62), string.char(s63))
    end
    b64 = b64:gsub(pattern, "")
    local t, k = {}, 1
    local n = #b64
    local padding = b64:sub(-2) == "==" and 2 or b64:sub(-1) == "=" and 1 or 0
    for i = 1, padding > 0 and n - 4 or n, 4 do
        local a, b, c, d = b64:byte(i, i + 3)
        local s
        if decoder ~= nil then
            if a == nil or b == nil or c == nil or d == nil or decoder[a] == nil or decoder[b] == nil or decoder[c] ==
                nil or decoder[d] == nil then
                return nil
            end
            local v = decoder[a] * 0x40000 + decoder[b] * 0x1000 + decoder[c] * 0x40 + decoder[d]
            s = string.char(extract(v, 16, 8), extract(v, 8, 8), extract(v, 0, 8))
        else
            print("Failed to decode string ( solitude )")
        end
        t[k] = s
        k = k + 1
    end
    if padding == 1 then
        local a, b, c = b64:byte(n - 3, n - 1)
        local v = decoder[a] * 0x40000 + decoder[b] * 0x1000 + decoder[c] * 0x40
        t[k] = string.char(extract(v, 16, 8), extract(v, 8, 8))
    elseif padding == 2 then
        local a, b = b64:byte(n - 3, n - 2)
        local v = decoder[a] * 0x40000 + decoder[b] * 0x1000
        t[k] = string.char(extract(v, 16, 8))
    end
    return table.concat(t)
end
table.unpack = function(t, i)
    local len = #t
    i = i or 1
    if i<len then
        return t[i],table.unpack(t,i+1)
    end
    return t[i]
end
math.encode = function(str)
    str = base64.encode(tostring(str))
    local result = {}
    local length = string.len(str)
    for n = 1, length do
        result[n] = string.byte(str, n)
    end
    return result
end
math.decode = function(tab)
    local str = ""
    for n = 1, #tab do
        str = str .. string.char(tab[n])
    end
    return base64.decode(str)
end
math.random_string = function(l)
    local return_string = ""
    for n = 1, l do
        local is_low = math.random(1, 2)
        if is_low == 1 then
            return_string = return_string .. string.char(math.random(65, 65 + 25))
        else
            return_string = return_string .. string.char(math.random(97, 97 + 25))
        end
    end
    return return_string
end
local json = {}

local function kind_of(obj)
    local var_type = type(obj)
    if var_type ~= 'table' then
        return var_type
    end
    local i = 1
    for _ in pairs(obj) do
        if obj[i] ~= nil then
            i = i + 1
        else
            return 'table'
        end
    end
    if i == 1 then
        return 'table'
    else
        return 'array'
    end
end

local function escape_str(s)
    local in_char = {'\\', '"', '/', '\b', '\f', '\n', '\r', '\t'}
    local out_char = {'\\', '"', '/', 'b', 'f', 'n', 'r', 't'}
    for i, c in ipairs(in_char) do
        s = s:gsub(c, '\\' .. out_char[i])
    end
    return s
end

local function skip_delim(str, pos, delim, err_if_missing)
    pos = pos + #str:match('^%s*', pos)
    if str:sub(pos, pos) ~= delim then
        if err_if_missing then
            error('Expected ' .. delim .. ' near position ' .. pos)
        end
        return pos, false
    end
    return pos + 1, true
end

local function parse_str_val(str, pos, val)
    val = val or ''
    local early_end_error = 'End of input found while parsing string. ( solitude )'
    if pos > #str then
        error(early_end_error)
    end
    local c = str:sub(pos, pos)
    if c == '"' then
        return val, pos + 1
    end
    if c ~= '\\' then
        return parse_str_val(str, pos + 1, val .. c)
    end
    -- We must have a \ character.
    local esc_map = {
        b = '\b',
        f = '\f',
        n = '\n',
        r = '\r',
        t = '\t'
    }
    local nextc = str:sub(pos + 1, pos + 1)
    if not nextc then
        error(early_end_error)
    end
    return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local function parse_num_val(str, pos)
    local num_str = str:match('^-?%d+%.?%d*[eE]?[+-]?%d*', pos)
    local val = tonumber(num_str)
    if not val then
        error('Error parsing number at position ' .. pos .. '. ( solitude )')
    end
    return val, pos + #num_str
end

function json.stringify(obj, as_key)
    local s = {}
    local kind = kind_of(obj)
    if kind == 'array' then
        if as_key then
            error('Can\'t encode array as key. ( solitude )')
        end
        s[#s + 1] = '['
        for i, val in ipairs(obj) do
            if i > 1 then
                s[#s + 1] = ','
            end
            s[#s + 1] = json.stringify(val)
        end
        s[#s + 1] = ']'
    elseif kind == 'table' then
        if as_key then
            error('Can\'t encode table as key. ( solitude )')
        end
        s[#s + 1] = '{'
        for k, v in pairs(obj) do
            if #s > 1 then
                s[#s + 1] = ', '
            end
            s[#s + 1] = json.stringify(k, true)
            s[#s + 1] = ':'
            s[#s + 1] = json.stringify(v)
        end
        s[#s + 1] = '}'
    elseif kind == 'string' then
        return '"' .. escape_str(obj) .. '"'
    elseif kind == 'number' then
        if as_key then
            return '"' .. tostring(obj) .. '"'
        end
        return tostring(obj)
    elseif kind == 'boolean' then
        return tostring(obj)
    elseif kind == 'nil' then
        return 'null'
    elseif kind == 'function' then
    else
        error('Unjsonifiable type: ' .. kind .. '. ( solitude )')
    end
    return table.concat(s)
end

json.null = {}

function json.parse(str, pos, end_delim)
    pos = pos or 1
    local str_len = #str
    if pos > str_len then
        error('Reached unexpected end of input. ( solitude )')
    end
    local pos = pos + #str:match('^%s*', pos) -- Skip whitespace.
    local first = str:sub(pos, pos)
    if first == '{' then -- Parse an object.
        local obj, key, delim_found = {}, true, true
        pos = pos + 1
        while true do
            key, pos = json.parse(str, pos, '}')
            if key == nil then
                return obj, pos
            end
            if not delim_found then
                error('Comma missing between object items. ( solitude )')
            end
            pos = skip_delim(str, pos, ':', true) -- true -> error if missing.
            if tonumber(key)~="fail" and tonumber(key)~=nil then key=tonumber(key) end
            obj[key], pos = json.parse(str, pos)
            pos, delim_found = skip_delim(str, pos, ',')
        end
    elseif first == '[' then -- Parse an array.
        local arr, val, delim_found = {}, true, true
        pos = pos + 1
        while true do
            val, pos = json.parse(str, pos, ']')
            if val == nil then
                return arr, pos
            end
            if not delim_found then
                error('Comma missing between array items. ( solitude )')
            end
            arr[#arr + 1] = val
            pos, delim_found = skip_delim(str, pos, ',')
        end
    elseif first == '"' then -- Parse a string.
        return parse_str_val(str, pos + 1)
    elseif first == '-' or first:match('%d') then -- Parse a number.
        return parse_num_val(str, pos)
    elseif first == end_delim then -- End of an object or array.
        return nil, pos + 1
    else -- Parse true, false, or null.
        local literals = {
            ['true'] = true,
            ['false'] = false,
            ['null'] = json.null
        }
        for lit_str, lit_val in pairs(literals) do
            local lit_end = pos + #lit_str - 1
            if str:sub(pos, lit_end) == lit_str then
                return lit_val, lit_end + 1
            end
        end
        local pos_info_str = 'position ' .. pos .. ': ' .. str:sub(pos, pos + 10)
        error('Invalid json syntax starting at ' .. pos_info_str..'. ( solitude )')
    end
end
function color(r, g, b, a)
    if r==nil then r = 255 end
    if g==nil then g = 255 end
    if b==nil then b = 255 end
    if a==nil then a = 255 end
    return color_t(math.floor(r+0.5), math.floor(g+0.5), math.floor(b+0.5), math.floor(a+0.5))
end
function clamp(v,min,max)
    if min>max then
        local n = max
        max = min
        min = n
    end
    return math.min(math.max(v,min),max)
end
function lerp(v, new_v, s)
    return clamp(v+(new_v-v)*s,v,new_v)
end
function inverse_lerp(v, new_v, s)
    local diff = (new_v-v)
    return clamp(v+diff-diff*s,v,new_v)
end
function normalize(v,min,max)
    local diff = max - min
    while v > max do v = v-diff end
    while v <min do v = v+diff end
    return v
end
function custom_clamp(v,min,max)
    if v>min then return min end
    if v<max then return max end
    return v
end
local gui = {}
gui.data = {}
local class_data = {}
class_data.keybind = {}
function class_data.keybind:new(tab,group,parent,name)
    local this_type = { element = parent:add_keybind(name), is_visible = true }
    function this_type:get()
        return self.element:get()
    end
    function this_type:get_key()
        return self.element:get_key()
    end
    function this_type:get_mode()
        return self.element:get_mode()
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    return this_type
end
class_data.color_picker = {}
function class_data.color_picker:new(tab,group,parent,name, def_c, show_alpha)
    gui.data[tab][group][name] = gui.data[tab][group][name] or parent:add_color_picker(name, def_c or color(), show_alpha or false)
    local this_type = { element = gui.data[tab][group][name], is_visible = true }
    function this_type:get()
        return self.element:get()
    end
    function this_type:set(v)
        return self.element:set(v)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    return this_type
end
class_data.checkbox = {}
function class_data.checkbox:new(tab,group, name, def_v)
    local this_type = { element = menu.add_checkbox(group, name, def_v and true or false), is_visible = true }
    function this_type:get()
        return self.element:get()
    end
    function this_type:set(v)
        return self.element:set(v)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    function this_type:add_color_picker(name, def_c, show_alpha)
        return class_data.color_picker:new(tab,group, self.element, name, def_c, show_alpha)
    end
    function this_type:add_keybind(name)
        return class_data.keybind:new(tab,group,self.element,name)
    end
    return this_type
end
class_data.text = {}
function class_data.text:new(tab,group, name)
    local this_type = { element = menu.add_text(group, name), is_visible = true }
    function this_type:get()
        return self.element:get()
    end
    function this_type:set(v)
        return self.element:set(v)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    function this_type:add_color_picker(name, def_c, show_alpha)
        return class_data.color_picker:new(tab,group, self.element, name, def_c, show_alpha)
    end
    function this_type:add_keybind(name)
        return class_data.keybind:new(tab,group,self.element,name)
    end
    return this_type
end
class_data.slider = {}
function class_data.slider:new(tab,group, name, min, max, step, precision, suffix)
    local this_type = { element = menu.add_slider(group, name, min, max, step, precision, suffix), is_visible = true }
    function this_type:get()
        return self.element:get()
    end
    function this_type:set(v)
        return self.element:set(v and true or false)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    function this_type:add_color_picker(name, def_c, show_alpha)
        return class_data.color_picker:new(tab,group, self.element, name, def_c, show_alpha)
    end
    function this_type:add_keybind(name)
        return class_data.keybind:new(tab,group,self.element,name)
    end
    return this_type
end
class_data.slider = {}
function class_data.slider:new(tab,group, name, min, max, step, precision, suffix)
    local this_type = { element = menu.add_slider(group, name, min, max, step, precision, suffix), is_visible = true }
    function this_type:get()
        return self.element:get()
    end
    function this_type:set(v)
        return self.element:set(v)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    function this_type:add_color_picker(name, def_c, show_alpha)
        return class_data.color_picker:new(tab,group, self.element, name, def_c, show_alpha)
    end
    function this_type:add_keybind(name)
        return class_data.keybind:new(tab,group,self.element,name)
    end
    return this_type
end
class_data.input = {}
function class_data.input:new(tab,group, name)
    local this_type = { element = menu.add_text_input(group, name), is_visible = true }
    function this_type:get()
        return self.element:get()
    end
    function this_type:set(v)
        return self.element:set(v)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    return this_type
end
class_data.list = {}
function class_data.list:new(tab,group, name, items, vis_items)
    local this_type = { element = menu.add_list(group, name, items, vis_items), is_visible = true }
    function this_type:get(s)
        if s then
            return self.element:get_active_item_name()
        else
            return self.element:get()
        end
    end
    function this_type:set(v)
        if type(v) == "number" then
            return self.element:set(v)
        else
            return self.element:set_by_name(v)
        end
    end
    function this_type:get_items()
        return self.element:get_items()
    end
    function this_type:set_items(items)
        return self.element:set_items(items)
    end
    function this_type:add_item(item)
        return self.element:add_item(item)
    end
    function this_type:remove_item(item)
        return self.element:remove_item(item)
    end
    function this_type:get_item(i)
        return self.element:get_item_name(i)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    function this_type:add_color_picker(name, def_c, show_alpha)
        return class_data.color_picker:new(tab,group, self.element, name, def_c, show_alpha)
    end
    function this_type:add_keybind(name)
        return class_data.keybind:new(tab,group,self.element,name)
    end
    return this_type
end
class_data.combo = {}
function class_data.combo:new(tab,group, name, items, vis_items)
    local this_type = { element = menu.add_selection(group, name, items, vis_items), is_visible = true }
    function this_type:get(s)
        if s then
            return items[self.element:get()]
        else
            return self.element:get()
        end
    end
    function this_type:set(v)
        if type(v) == "number" then
            return self.element:set(v)
        else
            return self.element:set_by_name(v)
        end
    end
    function this_type:get_items()
        return self.element:get_items()
    end
    function this_type:set_items(items)
        return self.element:set_items(items)
    end
    function this_type:add_item(item)
        return self.element:add_item(item)
    end
    function this_type:remove_item(item)
        return self.element:remove_item(item)
    end
    function this_type:get_item(i)
        return self.element:get_item_name(i)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    function this_type:add_color_picker(name, def_c, show_alpha)
        return class_data.color_picker:new(tab,group, self.element, name, def_c, show_alpha)
    end
    function this_type:add_keybind(name)
        return class_data.keybind:new(tab,group,self.element,name)
    end
    return this_type
end
class_data.multicombo = {}
function class_data.multicombo:new(tab,group, name, items, vis_items)
    local this_type = { element = menu.add_multi_selection(group, name, items, vis_items), is_visible = true }
    function this_type:get(i)
        if i~=nil then
            return self.element:get(i)
        else
            local values = {}
            local items = self.element:get_items()
            for n, item in ipairs(items) do
                values[n] = self.element:get(n)
            end
            return values
        end
    end
    function this_type:set(i,v)
        local t = type(i)
        if t == "number" then
            return self.element:set(i,v and true or false)
        elseif t=="string" then
            return self.element:set_by_name(i,v and true or false)
        elseif t=="table" then
            for n,val in ipairs(i) do
                self.element:set(n,val and true or false)
            end
            return true
        end
    end
    function this_type:is_selected()
        local items = self.element:get_items()
        for n, item in ipairs(items) do
            if self.element:get(n) then return true end
        end
        return false
    end
    function this_type:get_items()
        return self.element:get_items()
    end
    function this_type:set_items(items)
        return self.element:set_items(items)
    end
    function this_type:add_item(item)
        return self.element:add_item(item)
    end
    function this_type:remove_item(item)
        return self.element:remove_item(item)
    end
    function this_type:get_item(i)
        return self.element:get_item_name(i)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    function this_type:add_color_picker(name, def_c, show_alpha)
        return class_data.color_picker:new(tab,group, self.element, name, def_c, show_alpha)
    end
    function this_type:add_keybind(name)
        return class_data.keybind:new(tab,group,self.element,name)
    end
    return this_type
end
class_data.button = {}
function class_data.button:new(tab,group, name,callback)
    local this_type = { element = menu.add_button(group, name,callback), is_visible = true }
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return self.element:set_visible(vis)
    end
    return this_type
end
class_data.tab = {}
function class_data.tab:new(tab, group, side)
    local this_type = { is_visible = true}
    if side~=nil then menu.set_group_column(group,side) end
    function this_type:checkbox(name, def_v)
        gui.data[tab][group][name] = gui.data[tab][group][name] or class_data.checkbox:new(tab,group,name,def_v)
        return gui.data[tab][group][name]
    end
    function this_type:slider(name,min,max,step,precision,suffix)
        gui.data[tab][group][name] = gui.data[tab][group][name] or class_data.slider:new(tab,group,name,min,max,step,precision,suffix)
        return gui.data[tab][group][name]
    end
    function this_type:list(name,items,view_items)
        gui.data[tab][group][name] = gui.data[tab][group][name] or class_data.list:new(tab,group,name,items,view_items)
        return gui.data[tab][group][name]
    end
    function this_type:combo(name,items,view_items)
        gui.data[tab][group][name] = gui.data[tab][group][name] or class_data.combo:new(tab,group,name,items,view_items)
        return gui.data[tab][group][name]
    end
    function this_type:multicombo(name,items,view_items)
        gui.data[tab][group][name] = gui.data[tab][group][name] or class_data.multicombo:new(tab,group,name,items,view_items)
        return gui.data[tab][group][name]
    end
    function this_type:button(name,function_cb)
        gui.data[tab][group][name] = gui.data[tab][group][name] or class_data.button:new(tab,group,name,function_cb)
        return gui.data[tab][group][name]
    end
    function this_type:input(name)
        gui.data[tab][group][name] = gui.data[tab][group][name] or class_data.input:new(tab,group,name)
        return gui.data[tab][group][name]
    end
    function this_type:text(name)
        gui.data[tab][group][name] = gui.data[tab][group][name] or class_data.text:new(tab,group,name)
        return gui.data[tab][group][name]
    end
    function this_type:set_side(n)
        return menu.set_group_column(group,n)
    end
    function this_type:set_visible(v)
        local vis = v and true or false
        self.is_visible = vis
        return menu.set_group_visibility(group,vis)
    end
    return this_type
end
gui.tabs = {}
gui.config_tabs = {}
function gui:create(tab, group, side, disable_config)
    if gui.data[tab] == nil then
        gui.data[tab] = {}
        table.insert(gui.tabs,tab)
        if not disable_config then
            table.insert(gui.config_tabs,tab)
        end
    end
    local group_str = tab.." ~ "..group
    if not gui.data[tab][group_str] then
        gui.data[tab][group_str] = {}
    end
    return class_data.tab:new(tab,group_str,side)
end
local filesystem = {} filesystem.__index = {}

filesystem.class = ffi.cast(ffi.typeof("void***"), memory.create_interface("filesystem_stdio.dll", "VBaseFileSystem011"))
filesystem.v_table = filesystem.class[0]

filesystem.casts = {
    read_file = ffi.cast("int (__thiscall*)(void*, void*, int, void*)", filesystem.v_table[0]),
    write_file = ffi.cast("int (__thiscall*)(void*, void const*, int, void*)", filesystem.v_table[1]),
    open_file = ffi.cast("void* (__thiscall*)(void*, const char*, const char*, const char*)", filesystem.v_table[2]),
    close_file = ffi.cast("void (__thiscall*)(void*, void*)", filesystem.v_table[3]),
    file_size = ffi.cast("unsigned int (__thiscall*)(void*, void*)", filesystem.v_table[7]),
    file_exists = ffi.cast("bool (__thiscall*)(void*, const char*, const char*)", filesystem.v_table[10]),
}

filesystem.modes = {
    ["r"] = "r", ["w"] = "w", ["a"] = "a",
    ["r+"] = "r+", ["w+"] = "w+", ["a+"] = "a+",
    ["rb"] = "rb", ["wb"] = "wb", ["ab"] = "ab",
    ["rb+"] = "rb+", ["wb+"] = "wb+", ["ab+"] = "ab+",
}

filesystem.open = function(file, mode, id)
    if (not filesystem.modes[mode]) then error("Invalid Mode!") end

    local self = setmetatable({
        file = file,
        mode = mode,
        path_id = id,
        handle = filesystem.casts.open_file(filesystem.class, file, mode, id)
    }, filesystem)

    return self
end

filesystem.close = function(fs)
    filesystem.casts.close_file(filesystem.class, fs.handle)
end

filesystem.exists = function(file, id)
    return filesystem.casts.file_exists(filesystem.class, file, id)
end

filesystem.get_size = function(fs)
    return filesystem.casts.file_size(filesystem.class, fs.handle)
end

function filesystem.write(path, buffer)
    local fs = filesystem.open(path, "w", "MOD")
    filesystem.casts.write_file(filesystem.class, buffer, #buffer, fs.handle)
    filesystem.close(fs)
end

function filesystem.append(path, buffer)
    local fs = filesystem.open(path, "a", "MOD")
    filesystem.casts.write_file(filesystem.class, buffer, #buffer, fs.handle)
    filesystem.close(fs)
end

function filesystem.read(path)
    local fs = filesystem.open(path, "r", "MOD")
    local size = filesystem.get_size(fs)
    local output = ffi.new("char[?]", size + 1)
    filesystem.casts.read_file(filesystem.class, output, size, fs.handle)
    filesystem.close(fs)
    return ffi.string(output)
end
local build_info = {
    type = "debug",
    version = "0.1",
    user = {
        name = user.name,
        forum_name = user.name,
        hwid = tostring(filesystem.read("hwid.txt")),
        uid = tostring(user.uid)
    },
    acces = false,
    finalized = false,
}
local http = httpFactory:new({
    task_interval = 0.3,
    enable_debug = false,
    timeout = 10
})
print("hwid: ",build_info.user.hwid)
http:get("https://raw.githubusercontent.com/f3rdhvh/solitude_data/main/primordial/database.json", function(data)
    local serverData = "no acces"
    if (data:success()) then
        local parsed_data = json.parse(data.body)
        if parsed_data.versions.scripts[build_info.type]~=build_info.version then
            serverData = "invalid script version"
        elseif parsed_data.bans[build_info.user.hwid]~=nil and parsed_data.bans[build_info.user.hwid]==true then
            serverData = "banned"
        else
            for n = 0, #parsed_data.users do
                local user_data = parsed_data.users[n]
                if user_data.hwid==build_info.user.hwid and user_data.uid==build_info.user.uid then
                    if not user_data.banned then
                        if not build_info.acces and serverData=="no acces" then
                            build_info.acces = true
                            build_info.builds = user_data.builds
                            serverData = nil
                        else
                            build_info.acces = false
                            serverData = "multi accounting"
                        end
                    else
                        build_info.acces = false
                        serverData = "banned"
                    end

                end
            end
        end
    else
        client.log_screen("unable to reach solitude.solution servers.")
        serverData = "couldn't reach server"
        build_info.finalized = true
        return 0
    end
    if serverData==nil then
        if build_info.acces then

        else
            client.log_screen(color(),"unable to authentificate using solitude.solution servers ( status:",color(255,80,80),data.status,color(),"| reason:",color(255,80,80),"no acces",color(),"| hwid:",color(255,80,80),build_info.hwid,color(),")")
        end
    else
        client.log_screen(color(),"unable to authentificate using solitude.solution servers ( status:",color(255,80,80),data.status,color(),"| reason:",color(255,80,80),serverData,color(),"| hwid:",color(255,80,80),build_info.hwid,color(),")")
    end 
    build_info.finalized = true
end)
local lua_events = {}
local lua_render = {}
local antiaim = {}
antiaim.mode = 1
antiaim.bodyyaw = false
antiaim.local_state = 1
antiaim.exploit_state = 0
antiaim.state = 1
antiaim.waystate = 0
antiaim.state_table = {'shared','stand','crouch','slow walk','moving','air','air duck','charge dt','uncharge dt'}
local tab = {
    antiaim = {
        main = gui:create("Anti aim","main",2),
        yawbase = gui:create("Anti aim","yaw base",3),
        fakelag = gui:create("Anti aim","fake lag",1),
        defensive = gui:create("Anti aim","defensive",1),
        builder = {}
    },
    visuals = {
        elements = gui:create("Visualizations","ui elements",2),
        other = gui:create("Visualizations","other",3),
    },
    misc = {
        main = gui:create("Miscellaneous","main",2),
        localplayer = gui:create("Miscellaneous","local player",3)
    },
    config = {
        general = gui:create("Config system","general",2,true),
        cloud = gui:create("Config system","cloud",3,true),
        clipboard = gui:create("Config system","clipboard",3,true),
    }
}
local cache = {
    visual_elements = {'watermark','keybind list','info panel'},
    visual_elements_plus = {'shared','watermark','keybind list','info panel'},
    visual_styles = {'original','original plus'},
    visual_info = {},
    frametime = 0
}
cache.markers = { data = {} }
render.get_time = function(separate)
    local realtime = math.floor(globals.real_time())
    local seconds = realtime%60
    local minutes = math.floor(realtime/60)%60
    local hours = math.floor(realtime/3600)%24
    if separate then
        return { s = seconds, m = minutes, h = hours}
    end
    return (hours<10 and "0" or "")..tostring(hours)..":"..(minutes<10 and "0" or "")..tostring(minutes)..":"..(seconds<10 and "0" or "")..tostring(seconds)
end
render.lerp = function(v,new_v,speed)
    speed = speed or 0.3
    return (v+(new_v-v)*speed*60*cache.frametime)
end
render.hovered = function(from,to)
    local mouse = input.get_mouse_pos()
    return mouse.x>=from.x and mouse.x<=to.x and mouse.y>=from.y and mouse.y<=to.y
end
render.hovered_size = function(from,size)
    local mouse = input.get_mouse_pos()
    local to = vec2_t(from.x+size.x,from.y+size.y)
    return mouse.x>=from.x and mouse.x<=to.x and mouse.y>=from.y and mouse.y<=to.y
end
local lua = {
    tab = class_data.list:new("","Solitude.solutions","Cathegory picker",gui.tabs,#gui.tabs),
    antiaim = {
        enable = tab.antiaim.main:checkbox("enable anti aim",false),
        mode = tab.antiaim.main:combo("anti aim mode",{'global','per team'}),
        team = tab.antiaim.main:combo("select team",{'terrorist','counter terrorist'}),
        playerstate = tab.antiaim.main:combo("player state",antiaim.state_table,8),
        yawbase = tab.antiaim.yawbase:combo("yaw base",{'view angle','at targets ( view )','at targets ( distance )'}),
        yawdisablers = tab.antiaim.yawbase:multicombo("yaw disablers",{'on warmup','freeze time','no enemies alive'}),
        fakelag = tab.antiaim.fakelag:slider("fake lag amount",1,15),
        breaklagcomp = tab.antiaim.fakelag:checkbox("break lag compensation"),
        defensive = tab.antiaim.defensive:multicombo("defensive states",{'stand','crouch','slow walk','moving','air','air duck','auto peek','free stand'}),
        defensive_pitch = tab.antiaim.defensive:combo("defensive pitch",{'none','down','up','zero','jitter','sway','random'}),
        defensive_spin = tab.antiaim.defensive:slider("defensive spin",-180,180,1,0,'*'),
        defensive_spin_speed = tab.antiaim.defensive:slider("spin speed",1,100,1,0,'%'),
        builder = {}
    },
    visuals = {
        elements = tab.visuals.elements:multicombo("windows",cache.visual_elements),
        visualstate = tab.visuals.elements:combo("visual state",cache.visual_elements_plus),
        element_options = {},
        aimbotlogs = tab.visuals.other:multicombo("cheat event logs",{'screen','console'}),
        hitmarkers = tab.visuals.other:combo("hit markers",{'off','cross ( + )','cross ( x )'}),
        damagemarkers = tab.visuals.other:combo("damage markers",{'off','dynamic','static'}),
    },
    misc = {
        clantag = tab.misc.main:checkbox("clan tag",false),
        damageindicator = tab.misc.main:combo("damage indicator",{'off','default','top left','top right','bottom left','bottom right'}),
        damagecondition = tab.misc.main:combo("damage condition",{'always on','on override'}),
        localanimations = tab.misc.localplayer:multicombo("player animations",{'pitch 0 on land','movement lean'}),
        leanammount = tab.misc.localplayer:slider("lean amount",1,100,0.1,1,"%"),
        groundlegs = tab.misc.localplayer:combo("legs on ground",{'off','backwards static','backwards jitter','stand static','moonwalk'}),
        airlegs = tab.misc.localplayer:combo("legs in air",{'off','static','broken static','ground static','cocostarc','king kong walk','moonwalk'}),
    },
    config = {
        mode = tab.config.general:combo("config mode",{'cloud','clipboard'}),
        tabs = tab.config.clipboard:multicombo("select from tabs",gui.config_tabs),
        export = tab.config.clipboard:button("export selected tabs",function()
            clipboard.set(gui:export())
            client.log(color(230,230,255),"Exported config. ( solitude )")
        end),
        import = tab.config.clipboard:button("import selected tabs",function()
            gui:import(clipboard.get())
            client.log(color(230,230,255),"Imported config. ( solitude )")
        end),
    }
}
function gui:export(force_all_tabs)
    local aa_mode = lua.antiaim.mode:get()
    local tabs = lua.config.tabs:get()
    local exported_tabs = {}
    for n, tab in ipairs(gui.config_tabs) do
        if tabs[n] or force_all_tabs then
            table.insert(exported_tabs,tab)
        end
    end
    local exported_content = { }
    for n, tab in pairs(exported_tabs) do
        exported_content[tab] = {}
        for parent_name, parent in pairs(gui.data[tab]) do
            local continue = true
            if tab=="Anti aim" then
                local ct = parent_name:find("%(ct")
                local t = parent_name:find("%(t")
                local state = parent_name:find("state")
                if (aa_mode==1 and (ct~=nil or t~=nil) and state~=nil) or (aa_mode==2 and ct==nil and t==nil and state~=nil) then
                    continue = false
                end
            end
            if continue then
                exported_content[tab][parent_name] = {}
                for varname, element in pairs(parent) do
                    local element_value = element:get()
                    local t = type(element_value)
                    local v = element_value
                    if t=="userdata" then
                        v = {r=element_value.r,g=element_value.g,b=element_value.b,a=element_value.a}
                    end
                    exported_content[tab][parent_name][varname] = v
                end
            end
        end
    end
    return base64.encode(json.stringify(exported_content))
end
function gui:import(str,force_all_tabs)
    str = json.parse(base64.decode(str))
    local cfg_tabs = gui.config_tabs
    local selected_tabs = lua.config.tabs:get()
    local import_tabs = {}
    for n, tab in ipairs(gui.config_tabs) do
        if lua.config.tabs:get(tab) or force_all_tabs==true then
            import_tabs[tab] = true
        end
    end
    for tab_name, tab in pairs(str) do
        if import_tabs[tab_name] and gui.data[tab_name]~=nil then
            for parent_name, parent in pairs(tab) do
                if gui.data[tab_name][parent_name]~=nil then
                    for varname, value in pairs(parent) do
                        if gui.data[tab_name][parent_name][varname]~=nil then
                            local t = type(value)
                            if t~="table" then
                                gui.data[tab_name][parent_name][varname]:set(value)
                            else
                                if value.r~=nil then
                                    gui.data[tab_name][parent_name][varname]:set(color(value.r,value.g,value.b,value.a))
                                else
                                    gui.data[tab_name][parent_name][varname]:set(value)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return true
end
lua.visuals.aimbotlogs_color = lua.visuals.aimbotlogs:add_color_picker("cheat event logs color",color(),true)
lua.visuals.hitmarkers_color = lua.visuals.hitmarkers:add_color_picker("hit markers color")
lua.visuals.damagemarkers_color = lua.visuals.damagemarkers:add_color_picker("damage markers color")
lua.misc.damageindicator_color = lua.misc.damageindicator:add_color_picker("damage indicator color")
for n = 1, #cache.visual_elements_plus do
    local elements_reference = {}
    if n~=1 then
        elements_reference.override = tab.visuals.elements:checkbox("override "..cache.visual_elements_plus[n],false)
    end
    elements_reference.style = tab.visuals.elements:combo(cache.visual_elements_plus[n].." - style",cache.visual_styles)
    elements_reference.color = elements_reference.style:add_color_picker(cache.visual_elements_plus[n].." - color",color())
    elements_reference.background = tab.visuals.elements:slider(cache.visual_elements_plus[n].." - background alpha",0,100,0.1,1,"%")
    lua.visuals.element_options[n] = elements_reference
end
class_data.create_builder = function(parent,state,override)
    local base_str = state.." - "
    local builder_reference = {}
    if override then
        builder_reference.override = parent:checkbox("override "..state,false)
    end
    builder_reference.pitch = parent:combo("pitch",{'none','down','up','zero','jitter','sway','random'})
    builder_reference.yawmode = parent:combo("yaw mode",{'default','left / right'})
    builder_reference.yawadd = parent:slider("yaw add",-180,180,1,0,'*')
    builder_reference.yawaddleft = parent:slider("yaw add left",-180,180,1,0,'*')
    builder_reference.yawaddright = parent:slider("yaw add right",-180,180,1,0,'*')
    builder_reference.yawmodifier = parent:combo("yaw modifier",{'disabled','random','offset jitter','center jitter','sway jitter','random jitter','spin','3 way','5 way','x way'})
    builder_reference.xways = {}
    builder_reference.xways.limit = parent:slider("way limit",3,14,1,0,' ways')
    builder_reference.xways.customways = parent:checkbox("custom ways",false)
    builder_reference.jitterdelay = {}
    builder_reference.jitterdelay.enable = parent:combo("jitter delay",{'none','global','custom'})
    builder_reference.jitterdelay.global = parent:slider("global delay",1,8)
    builder_reference.jitterdelay.left = parent:slider("delay left",1,8)
    builder_reference.jitterdelay.right = parent:slider("delay right",1,8)
    for i = 1, 14 do
        builder_reference.xways[i] = parent:slider("way "..tostring(i),-180,180,1,0,'*')
        builder_reference.jitterdelay[i] = parent:slider("delay "..tostring(i),1,8)
    end
    builder_reference.modifierdegree = parent:slider("modifier degree",-180,180,1,0,'*')
    builder_reference.spinspeed = parent:slider("spin speed",1,100,1,0,'%')
    builder_reference.bodyyaw = parent:combo("body yaw",{'off','static','jitter'})
    builder_reference.desynclimit = parent:slider("desync limit",-60,60,1,0,'*')
    builder_reference.desyncleft = parent:slider("desync left",0,60,1,0,'*')
    builder_reference.desyncright = parent:slider("desync right",0,60,1,0,'*')
    builder_reference.desyncbreaker = parent:checkbox("desync breaker")
    builder_reference.antibrute = parent:checkbox("enable anti brute force")
    return builder_reference
end
class_data.create_anti_brute = function(parent)
    local builder_reference = {}
    builder_reference.limit = parent:slider("anti brute force states",1,10)
    builder_reference.select = parent:combo("select anti brute force state",{})
    for n = 1, 10 do
        local antibrute_reference = {}
        local str_add = tostring(n).." ~ "
        antibrute_reference.customizeyaw = parent:checkbox(str_add.."customize yaw")
        antibrute_reference.pitch = parent:combo(str_add.."pitch",{'none','down','up','zero','jitter','sway','random'})
        antibrute_reference.yawmode = parent:combo(str_add.."yaw mode",{'default','left / right'})
        antibrute_reference.yawadd = parent:slider(str_add.."yaw add",-180,180,1,0,'*')
        antibrute_reference.yawaddleft = parent:slider(str_add.."yaw add left",-180,180,1,0,'*')
        antibrute_reference.yawaddright = parent:slider(str_add.."yaw add right",-180,180,1,0,'*')
        antibrute_reference.yawmodifier = parent:combo(str_add.."yaw modifier",{'disabled','random','offset jitter','center jitter','sway jitter','random jitter','spin','3 way','5 way','x way'})
        antibrute_reference.xways = {}
        antibrute_reference.xways.limit = parent:slider(str_add.."way limit",3,14,1,0,' ways')
        antibrute_reference.xways.customways = parent:checkbox(str_add.."custom ways",false)
        antibrute_reference.jitterdelay = {}
        antibrute_reference.jitterdelay.enable = parent:combo(str_add.."jitter delay",{'none','global','custom'})
        antibrute_reference.jitterdelay.global = parent:slider(str_add.."global delay",1,8)
        antibrute_reference.jitterdelay.left = parent:slider(str_add.."delay left",1,8)
        antibrute_reference.jitterdelay.right = parent:slider(str_add.."delay right",1,8)
        for i = 1, 14 do
            antibrute_reference.xways[i] = parent:slider(str_add.."way "..tostring(i),-180,180,1,0,'*')
            antibrute_reference.jitterdelay[i] = parent:slider(str_add.."delay "..tostring(i),1,8)
        end
        antibrute_reference.modifierdegree = parent:slider(str_add.."modifier degree",-180,180,1,0,'*')
        antibrute_reference.spinspeed = parent:slider(str_add.."spin speed",1,100,1,0,'%')
        antibrute_reference.customizedesync = parent:checkbox(str_add.."customize desync")
        antibrute_reference.bodyyaw = parent:combo(str_add.."body yaw",{'off','static','jitter'})
        antibrute_reference.desynclimit = parent:slider(str_add.."desync limit",-60,60,1,0,'*')
        antibrute_reference.desyncleft = parent:slider(str_add.."desync left",0,60,1,0,'*')
        antibrute_reference.desyncright = parent:slider(str_add.."desync right",0,60,1,0,'*')
        antibrute_reference.desyncbreaker = parent:checkbox(str_add.."desync breaker")
        builder_reference[n] = antibrute_reference
    end
    return builder_reference
end
for n = 1, #antiaim.state_table do
    local state_name = antiaim.state_table[n]
    local states = { state_name,state_name.." (t)",state_name.." (ct)"}
    tab.antiaim.builder[n] = tab.antiaim.builder[n] or { global =  { main = gui:create("Anti aim",state_name.." state",2), antibrute = gui:create("Anti aim",state_name.." anti brute",3) } , teams = { main = {gui:create("Anti aim",state_name.." state (t)",2),gui:create("Anti aim",state_name.." state (ct)",2)}, antibrute = {gui:create("Anti aim",state_name.." anti brute (t)",3),gui:create("Anti aim",state_name.." anti brute (ct)",3)}}}
    local demo_version = { 
        [1] = { main = class_data.create_builder(tab.antiaim.builder[n].global.main,states[1],n~=1), antibrute = class_data.create_anti_brute(tab.antiaim.builder[n].global.antibrute)},
        [2] = { main = class_data.create_builder(tab.antiaim.builder[n].teams.main[1],states[2],n~=1), antibrute = class_data.create_anti_brute(tab.antiaim.builder[n].teams.antibrute[1])},
        [3] = { main = class_data.create_builder(tab.antiaim.builder[n].teams.main[2],states[3],n~=1), antibrute = class_data.create_anti_brute(tab.antiaim.builder[n].teams.antibrute[2])},
    }
    for t = 1, 3 do
        lua.antiaim.builder[t] = lua.antiaim.builder[t] or {}
        lua.antiaim.builder[t][n] = demo_version[t]
    end
end
class_data.set_visible_builder = function(builder_reference,enable_state)
    if builder_reference.override~=nil then
        builder_reference.override:set_visible(enable_state)
    end
    enable_state = enable_state and (builder_reference.override == nil or builder_reference.override:get())
    builder_reference.pitch:set_visible(enable_state)
    builder_reference.yawmode:set_visible(enable_state)
    local yawmode = builder_reference.yawmode:get()
    builder_reference.yawadd:set_visible(enable_state and yawmode==1)
    builder_reference.yawaddleft:set_visible(enable_state and yawmode==2)
    builder_reference.yawaddright:set_visible(enable_state and yawmode==2)
    builder_reference.yawmodifier:set_visible(enable_state)
    local yawmodifier = builder_reference.yawmodifier:get()
    builder_reference.xways.limit:set_visible(enable_state and yawmodifier==10)
    builder_reference.xways.customways:set_visible(enable_state and yawmodifier>7)
    builder_reference.jitterdelay.enable:set_visible(enable_state and yawmodifier>2 and yawmodifier~=6 and yawmodifier~=7)
    local jitterdelay = builder_reference.jitterdelay.enable:get()
    local jitterdelay_condition = yawmodifier>2 and yawmodifier~=6 and yawmodifier~=7
    builder_reference.jitterdelay.global:set_visible(enable_state and jitterdelay_condition and jitterdelay==2)
    builder_reference.jitterdelay.left:set_visible(enable_state and jitterdelay_condition and jitterdelay==3 and yawmodifier<6)
    builder_reference.jitterdelay.right:set_visible(enable_state and jitterdelay_condition and jitterdelay==3 and yawmodifier<6)
    local customways = builder_reference.xways.customways:get()
    local waylimit = 4
    if yawmodifier==9 then waylimit = 6 elseif yawmodifier==10 then waylimit = builder_reference.xways.limit:get()+1 end
    for i = 1, 14 do
        builder_reference.xways[i]:set_visible(enable_state and yawmodifier>7 and customways and i<waylimit)
        builder_reference.jitterdelay[i]:set_visible(enable_state and jitterdelay_condition and jitterdelay==3 and yawmodifier>7 and i<waylimit)
    end
    builder_reference.modifierdegree:set_visible(enable_state and yawmodifier~=1 and (yawmodifier<8 or not customways))
    builder_reference.spinspeed:set_visible(enable_state and yawmodifier==7)
    builder_reference.bodyyaw:set_visible(enable_state)
    local bodyyaw = builder_reference.bodyyaw:get()
    builder_reference.desynclimit:set_visible(enable_state and bodyyaw==2)
    builder_reference.desyncleft:set_visible(enable_state and bodyyaw==3)
    builder_reference.desyncright:set_visible(enable_state and bodyyaw==3)
    builder_reference.desyncbreaker:set_visible(enable_state and bodyyaw==3 and yawmodifier==10)
    builder_reference.antibrute:set_visible(enable_state)
end
class_data.set_visible_antibrute = function(builder_reference,enable_anti_brute)
    builder_reference.limit:set_visible(enable_anti_brute)
    local limit = builder_reference.limit:get()
    local select_elem = {}
    for n = 1, limit do
        select_elem[n] = tostring(n)
    end
    local select = math.min(builder_reference.select:get(),limit)
    builder_reference.select:set(select)
    builder_reference.select:set_items(select_elem)
    builder_reference.select:set_visible(enable_anti_brute)
    for n = 1, 10 do
        local antibrute_reference = builder_reference[n]
        local enable_state = enable_anti_brute and n==select
        antibrute_reference.customizeyaw:set_visible(enable_state)
        local customizeyaw = antibrute_reference.customizeyaw:get()
        antibrute_reference.pitch:set_visible(enable_state and customizeyaw)
        antibrute_reference.yawmode:set_visible(enable_state and customizeyaw)
        local yawmode = antibrute_reference.yawmode:get()
        antibrute_reference.yawadd:set_visible(enable_state and customizeyaw and yawmode==1)
        antibrute_reference.yawaddleft:set_visible(enable_state and customizeyaw and yawmode==2)
        antibrute_reference.yawaddright:set_visible(enable_state and customizeyaw and yawmode==2)
        antibrute_reference.yawmodifier:set_visible(enable_state and customizeyaw)
        local yawmodifier = antibrute_reference.yawmodifier:get()
        antibrute_reference.xways.limit:set_visible(enable_state and customizeyaw and yawmodifier==10)
        antibrute_reference.xways.customways:set_visible(enable_state and customizeyaw and yawmodifier>7)
        antibrute_reference.jitterdelay.enable:set_visible(enable_state and customizeyaw and yawmodifier>2 and yawmodifier~=6 and yawmodifier~=7)
        local jitterdelay = antibrute_reference.jitterdelay.enable:get()
        local jitterdelay_condition = yawmodifier>2 and yawmodifier~=6 and yawmodifier~=7
        antibrute_reference.jitterdelay.global:set_visible(enable_state and customizeyaw and jitterdelay_condition and jitterdelay==2)
        antibrute_reference.jitterdelay.left:set_visible(enable_state and customizeyaw and jitterdelay_condition and jitterdelay==3 and yawmodifier<6)
        antibrute_reference.jitterdelay.right:set_visible(enable_state and customizeyaw and jitterdelay_condition and jitterdelay==3 and yawmodifier<6)
        local customways = antibrute_reference.xways.customways:get()
        local waylimit = 4
        if yawmodifier==9 then waylimit = 6 elseif yawmodifier==10 then waylimit = antibrute_reference.xways.limit:get()+1 end
        for i = 1, 14 do
            antibrute_reference.xways[i]:set_visible(enable_state and customizeyaw and yawmodifier>7 and customways and i<waylimit)
            antibrute_reference.jitterdelay[i]:set_visible(enable_state and customizeyaw and jitterdelay_condition and jitterdelay==3 and yawmodifier>7 and i<waylimit)
        end
        antibrute_reference.modifierdegree:set_visible(enable_state and customizeyaw and yawmodifier~=1 and (yawmodifier<8 or not customways))
        antibrute_reference.spinspeed:set_visible(enable_state and customizeyaw and yawmodifier==7)
        antibrute_reference.customizedesync:set_visible(enable_state)
        local customizedesync = antibrute_reference.customizedesync:get()
        antibrute_reference.bodyyaw:set_visible(enable_state and customizedesync)
        local bodyyaw = antibrute_reference.bodyyaw:get()
        antibrute_reference.desynclimit:set_visible(enable_state and customizedesync and bodyyaw==2)
        antibrute_reference.desyncleft:set_visible(enable_state and customizedesync and bodyyaw==3)
        antibrute_reference.desyncright:set_visible(enable_state and customizedesync and bodyyaw==3)
        antibrute_reference.desyncbreaker:set_visible(enable_state and customizedesync and bodyyaw==3 and yawmodifier==10)
    end
end
lua_render.elements_visibility = function()
    cache.frametime = globals.frame_time()
    local selected_tab = lua.tab:get()
    if menu.is_open() then 
        tab.antiaim.main:set_visible(selected_tab==1)
        lua.antiaim.enable:set_visible(selected_tab==1)
        local enabled_aa = lua.antiaim.enable:get()
        lua.antiaim.mode:set_visible(selected_tab==1 and enabled_aa)
        local mode_aa = lua.antiaim.mode:get()
        lua.antiaim.playerstate:set_visible(selected_tab==1 and enabled_aa)
        lua.antiaim.team:set_visible(selected_tab==1 and enabled_aa and mode_aa==2)
        local team_aa = lua.antiaim.team:get()
        local player_state = lua.antiaim.playerstate:get()
        tab.antiaim.yawbase:set_visible(selected_tab==1 and enabled_aa)
        tab.antiaim.fakelag:set_visible(selected_tab==1 and enabled_aa)
        tab.antiaim.defensive:set_visible(selected_tab==1 and enabled_aa)
        local parent_enablers = {selected_tab==1 and enabled_aa and mode_aa==1,selected_tab==1 and enabled_aa and mode_aa==2 and team_aa==1,selected_tab==1 and enabled_aa and mode_aa==2 and team_aa==2}
        for n = 1, #antiaim.state_table do
            tab.antiaim.builder[n].global.main:set_visible(parent_enablers[1] and player_state==n)
            tab.antiaim.builder[n].global.antibrute:set_visible(tab.antiaim.builder[n].global.main.is_visible)
            tab.antiaim.builder[n].teams.main[1]:set_visible(parent_enablers[2] and player_state==n)
            tab.antiaim.builder[n].teams.antibrute[1]:set_visible(tab.antiaim.builder[n].teams.main[1].is_visible)
            tab.antiaim.builder[n].teams.main[2]:set_visible(parent_enablers[3] and player_state==n)
            tab.antiaim.builder[n].teams.antibrute[2]:set_visible(tab.antiaim.builder[n].teams.main[2].is_visible)
            if tab.antiaim.builder[n].global.main.is_visible then
                class_data.set_visible_builder(lua.antiaim.builder[1][n].main,true)
                local is_anti_brute = lua.antiaim.builder[1][n].main.antibrute:get()
                class_data.set_visible_antibrute(lua.antiaim.builder[1][n].antibrute,is_anti_brute)
            elseif tab.antiaim.builder[n].teams.main[1].is_visible then
                class_data.set_visible_builder(lua.antiaim.builder[2][n].main,true)
                local is_anti_brute = lua.antiaim.builder[2][n].main.antibrute:get()
                class_data.set_visible_antibrute(lua.antiaim.builder[2][n].antibrute,is_anti_brute)
            elseif tab.antiaim.builder[n].teams.main[2].is_visible then
                class_data.set_visible_builder(lua.antiaim.builder[3][n].main,true)
                local is_anti_brute = lua.antiaim.builder[3][n].main.antibrute:get()
                class_data.set_visible_antibrute(lua.antiaim.builder[3][n].antibrute,is_anti_brute)
            end
        end
        tab.visuals.elements:set_visible(selected_tab==2)
        local is_selected_elements = lua.visuals.elements:is_selected()
        lua.visuals.visualstate:set_visible(selected_tab==2 and is_selected_elements)
        local visual_state = lua.visuals.visualstate:get()
        for n = 1, #cache.visual_elements_plus do
            local element = cache.visual_elements_plus[n]
            local elements_reference = lua.visuals.element_options[n]
            if n~=1 then
                elements_reference.override:set_visible(selected_tab==2 and is_selected_elements and visual_state==n)
            end
            local base_condition = selected_tab==2 and is_selected_elements and visual_state==n and (n==1 or elements_reference.override:get())
            elements_reference.style:set_visible(base_condition)
            elements_reference.background:set_visible(base_condition)
            if n==1 or elements_reference.override:get() then
                cache.visual_info[element] = { style = elements_reference.style:get(),color = elements_reference.color:get(), background = elements_reference.background:get()}
            else
                cache.visual_info[element] = cache.visual_info[cache.visual_elements_plus[1]]
            end
        end
        tab.visuals.other:set_visible(selected_tab==2)
        tab.misc.main:set_visible(selected_tab==3)
        lua.misc.damagecondition:set_visible(lua.misc.damageindicator:get()>2)
        tab.misc.localplayer:set_visible(selected_tab==3)
        if tab.misc.localplayer then
            local animations = lua.misc.localanimations:get()
            lua.misc.leanammount:set_visible(animations[2])
        end
        cache.markers.hit = {
            v = lua.visuals.hitmarkers:get(),
            c = lua.visuals.hitmarkers_color:get()
        }
        cache.markers.damage = {
            v = lua.visuals.damagemarkers:get(),
            c = lua.visuals.damagemarkers_color:get()
        }
        tab.config.general:set_visible(selected_tab==4)
        local config_mode = lua.config.mode:get()
        --tab.config.cloud:set_visible(selected_tab==4 and config_mode==1)
        tab.config.clipboard:set_visible(selected_tab==4 and config_mode==2)
    end
end
local visual_element = {}
visual_element.active = 0
function visual_element:create(varname)
    local screen = render.get_screen_size()
    local ref_x = tab.visuals.elements:slider(varname.."_x",0,screen.x,1,1);ref_x:set_visible(false)
    local ref_y = tab.visuals.elements:slider(varname.."_y",0,screen.y,1,1);ref_y:set_visible(false)
    local this_type = { varname = varname, alpha = 255, def_pos = false, ref_x = ref_x, ref_y = ref_y, offset = vec2_t(0,0) }
    function this_type:render(condition,default_pos,size,show_outline)
        local pos = vec2_t(self.ref_x:get(),self.ref_y:get())
        if not self.def_pos and pos.x==0 and pos.y==0 then
            self.def_pos = true
            pos = default_pos
        end
        local mouse = input.get_mouse_pos()
        local visible_menu = menu.is_open()
        self.alpha = render.lerp(self.alpha,(condition or visible_menu) and 255 or 0)
        if self.alpha>10 then
            local hovered_element = render.hovered_size(pos,size)
            local hovered_menu = render.hovered_size(menu.get_pos(),menu.get_size())
            local hovered = hovered_element and not hovered_menu
            if hovered and visual_element.active==0 and input.is_key_pressed(e_keys.MOUSE_LEFT) then
                visual_element.active=self.varname
            elseif visual_element.active==self.varname then
                if input.is_key_held(e_keys.MOUSE_LEFT) then
                    pos = vec2_t(mouse.x-self.offset.x,mouse.y-self.offset.y)
                else
                    visual_element.active = 0
                end
            else
                self.offset = vec2_t(mouse.x-pos.x,mouse.y-pos.y)
            end
        else
            if visual_element.active==self.varname then
                visual_element.active = 0
            end
        end
        self.ref_x:set(pos.x)
        self.ref_y:set(pos.y)
        return {
            pos = pos,
            alpha = self.alpha,
            size = size
        }
    end
    return this_type
end
local public_fonts = {
    default = render.get_default_font(),
    visuals = {
        main = render.create_font("Tahoma", 13, 600, e_font_flags.ANTIALIAS,e_font_flags.DROPSHADOW)
    },
    marker = {
        small = render.create_font("Verdana", 13, 600, e_font_flags.ANTIALIAS,e_font_flags.DROPSHADOW),
        big = render.create_font("Verdana", 18, 600, e_font_flags.ANTIALIAS,e_font_flags.DROPSHADOW),
    }
}
function visual_element:render(varname,from,to,alpha,under_height,custom_args)
    if under_height==nil or under_height<8 then under_height = 8 end
    local rounding = 3
    local info = cache.visual_info[varname] or cache.visual_info["shared"]
    local disable_line = false
    local style = info.style
    local col = info.color
    local background = math.min(math.floor(info.background*0.01*alpha),255)
    if custom_args~=nil then
        if custom_args.background~=nil then background = math.min(math.floor(custom_args.background*0.01*alpha),255) end
        if custom_args.color~=nil then col = custom_args.color end
        if custom_args.style~=nil then style = custom_args.style end
        if custom_args.disable_line then disable_line = custom_args.disable_line end
    end
    local size = vec2_t(to.x-from.x,to.y-from.y)
    if style==1 then
        render.push_clip(from, size)
        render.rect_filled(vec2_t(from.x-1,from.y-1), vec2_t(size.x+1,size.y+under_height), color(47,47,47,background),5)
        render.pop_clip()
        render.push_clip(vec2_t(from.x,to.y), vec2_t(size.x,under_height))
        render.rect_filled(vec2_t(from.x-1,to.y-6), vec2_t(size.x+1,under_height+7), color(35,35,35,background),5)
        render.pop_clip()
        if not disable_line then
            render.rect_filled(vec2_t(from.x+1,to.y), vec2_t(size.x-1,1), color(col.r,col.g,col.b,col.a/255*alpha))
        end
        render.rect(vec2_t(from.x-1,from.y-1), vec2_t(size.x+2,size.y+under_height+2), color(3,3,3,background),4)
    elseif style==2 then
        render.push_clip(vec2_t(from.x-1,from.y-1), vec2_t(size.x+2,size.y+1))
        render.rect_filled(vec2_t(from.x-1,from.y-1), vec2_t(size.x+2,size.y+5), color(47,47,47,background),5)
        render.rect(vec2_t(from.x-1,from.y-1), vec2_t(size.x+2,size.y+5), color(3,3,3,background),4)
        render.pop_clip()
        if not disable_line then
            render.rect_filled(vec2_t(from.x+1,to.y), vec2_t(size.x-1,1), color(col.r,col.g,col.b,col.a/255*alpha))
        end
        local under_alpha = math.min(under_height/14,1)*background
        if varname=="watermark" and under_height<14 then under_alpha=0 end
        if under_alpha>10 then
            under_height = under_height - 4
            render.rect_filled(vec2_t(from.x,to.y+4), vec2_t(size.x,under_height), color(35,35,35,under_alpha),5)
            render.rect(vec2_t(from.x,to.y+4), vec2_t(size.x,under_height), color(3,3,3,under_alpha*0.8),5)
        end
    end
end
local windows = {
    keybind_list = visual_element:create("keybind list"),
    spectator_list = visual_element:create("spectator list"),
    info_panel = visual_element:create("info panel"),
}
local clantag_data = {}
clantag_data.animations = {
    "⚡️ solitude ",
    "⚡️ olitude s",
    "⚡️ litude so",
    "⚡️ itude sol",
    "⚡️ tude soli",
    "⚡️ ude solit",
    "⚡️ de solitu",
    "⚡️ e solitud",
    "⚡️  solitude",
    "⚡️ solitude ",
    "⚡️ olitude ",
    "⚡️ litude ",
    "⚡️ itude ",
    "⚡️ tude ",
    "⚡️ ude ",
    "⚡️ de ",
    "⚡️ e ",
    "⚡️  ",
    "⚡️  s",
    "⚡️  so",
    "⚡️  sol",
    "⚡️  soli",
    "⚡️  solit",
    "⚡️  solitu",
    "⚡️  solitud",
    "⚡️  solitude",
    "⚡️ solitude ",
}
clantag_data.should_reset = false
clantag_data.curtime_hist = 0
lua_render.clantag = function()
    local enable_clantag = lua.misc.clantag:get()
    if not enable_clantag or not engine.is_connected() then
        if clantag_data.should_reset then
            clantag_data.should_reset = false
            client.set_clantag("")
        end
        return 0
    end
    local latency = engine.get_latency()
    local curtime = math.floor(globals.cur_time()*3+latency)
    if clantag_data.curtime_hist~=curtime then
        clantag_data.curtime_hist=curtime
        client.set_clantag(clantag_data.animations[curtime%(#clantag_data.animations)+1])
        clantag_data.should_reset=true
    end
end
lua_render.damageindicator = function()
    local damage_indicator = lua.misc.damageindicator:get()
    local damage_condition = lua.misc.damagecondition:get()
    local damage_color = lua.misc.damageindicator_color:get()
    local rage_index = ragebot.get_active_cfg()
    local rage_weapons = {"auto","scout","awp","deagle","revolver","pistols","other"}
    local weapon = rage_weapons[rage_index+1]
    if not weapon then return end
    local binds = {
        damage = menu.find("aimbot",weapon,"targeting","min. damage"),
        damage_override = menu.find("aimbot",weapon,"target overrides","min. damage")[1],
        damage_override_bind = menu.find("aimbot",weapon,"target overrides","min. damage")[2],
    }
    local override = {
        damage = binds.damage_override:get(),
        bind = {
            get = binds.damage_override_bind:get(),
            key = binds.damage_override_bind:get_key(),
            mode = binds.damage_override_bind:get_mode(),
        },
    }
    local screen = render.get_screen_size()
    if damage_indicator == 2 then
        local override_state = not override.bind.get and "0" or (override.bind.mode==0 and "2" or (override.bind.mode<3 and "1" or "3"))
        local damage_value = binds.damage:get()
        if override.bind.get then damage_value = override.damage end
        local state_size = render.get_text_size(public_fonts.visuals.main,override_state)
        local spacing = 9
        render.text(public_fonts.visuals.main, override_state, vec2_t(screen.x*0.5-spacing-state_size.x+1, screen.y*0.47), color(damage_color.r, damage_color.g, damage_color.b))
        render.text(public_fonts.visuals.main, tostring(damage_value), vec2_t(screen.x*0.5+spacing, screen.y*0.47), color(damage_color.r, damage_color.g, damage_color.b))
    else
        if damage_condition==2 and not override.bind.get then return end
        local damage_value = tostring(binds.damage:get())
        if override.bind.get then damage_value = tostring(override.damage) end
        local damage_size = render.get_text_size(public_fonts.visuals.main,damage_value)
        local offset = vec2_t(0,0)
        if damage_indicator==3 then offset = vec2_t(-damage_size.x-3,-damage_size.y-2)
        elseif damage_indicator==4 then offset = vec2_t(4,-damage_size.y-2)
        elseif damage_indicator==5 then offset = vec2_t(-damage_size.x-3,2)
        else offset = vec2_t(4,2) end
        render.text(public_fonts.visuals.main, damage_value, vec2_t(screen.x*0.5+offset.x, screen.y*0.5+offset.y), color(damage_color.r, damage_color.g, damage_color.b))
    end
end
client.create_log = function(title, args, total_text, col ,add_time)
    table.insert(lua_events,{title=title,args = args, total_text = total_text,time = globals.real_time() or 0, col = col or color(), add_time = add_time or 3.5})
end
lua_render.aimbotlogs = function()
    local screen = render.get_screen_size()
    local logs_position = vec2_t(screen.x*0.5,screen.y*0.58)
    local e_len = #lua_events
    if e_len>8 then
        table.remove(lua_events,1)
        e_len = e_len-1
    end
    local realtime = globals.real_time()
    local removal = -1
    local fade = {
        _in = 0.15,
        _out = 0.3
    }
    local border = vec2_t(8,4)
    for n = 0,e_len-1 do
        local log = lua_events[e_len-n]
        local time = log.time
        local add_time = log.add_time
        local log_col = log.col
        local log_time = time+add_time
        local time_diff = log_time-realtime
        local time_start = add_time-time_diff
        local pct = time_diff/add_time
        local alpha = 255
        if time_start<=fade._in then
            alpha = time_start/fade._in*255
        elseif time_diff<=fade._out then
            alpha = time_diff/fade._out*255
        end
        if realtime>=log_time then
            alpha = 0
            removal = e_len-n
        end
        local text_size = render.get_text_size(public_fonts.default,log.total_text)
        visual_element:render("aim bot logs",vec2_t(logs_position.x-text_size.x*0.5-border.x,logs_position.y),vec2_t(logs_position.x+text_size.x*0.5+border.x,logs_position.y+17),alpha,text_size.y+border.y*2+2,{background = log_col.a/2.55,color = log_col,style=1,disable_line=true})
        render.text(public_fonts.default,log.title,vec2_t(logs_position.x,logs_position.y+8),color(255,255,255,alpha),true)
        render.rect_filled(vec2_t(logs_position.x-(text_size.x*0.5+border.x)*pct,logs_position.y+16),vec2_t((text_size.x+border.x*2)*pct,1), color(log_col.r,log_col.g,log_col.b,alpha))
        local text_add = 0
        for i, arg in ipairs(log.args) do
            render.text(public_fonts.default,arg.text,vec2_t(logs_position.x-text_size.x*0.5+text_add,logs_position.y+17+border.y),color(arg.col.r,arg.col.g,arg.col.b,alpha))
            text_add= text_add + render.get_text_size(public_fonts.default,arg.text.." ").x
        end
        logs_position.y=logs_position.y+(17+text_size.y+border.y*2)*alpha/255+10
    end
    if removal~=-1 then table.remove(lua_events,removal) end
end
lua_render.watermark = function()
    local visual_info = cache.visual_info["watermark"] or cache.visual_info["shared"]
    local watermak_args = {
        {text = "solitude ",col = color()},
        {text = build_info.type.."   ", col = color(visual_info.color.r/255*190+65,visual_info.color.g/255*190+65,visual_info.color.b/255*190+65)},
        {text = build_info.user.name.."  ",col = color()},
        {text = render.get_time(),col = color()},
    }
    local screen = render.get_screen_size()
    local screen_border = vec2_t(5,5)
    local inside_border = vec2_t(8,3)
    local total_text = ""
    for n = 1,#watermak_args do
        if watermak_args[n].condition==nil or watermak_args[n].condition then
            total_text=total_text..watermak_args[n].text
        end
    end
    local text_size = render.get_text_size(public_fonts.default, total_text)
    local from = vec2_t(screen.x-screen_border.x-inside_border.x*2-text_size.x,screen_border.y)
    local to = vec2_t(screen.x-screen_border.x,screen_border.y+17)
    local text_pos = vec2_t(screen.x-screen_border.x-inside_border.x-text_size.x,screen_border.y+inside_border.y-1)
    visual_element:render("watermark",from,to,255,8)
    local text_add = 0
    for n = 1,#watermak_args do
        if watermak_args[n].condition==nil or watermak_args[n].condition then
            render.text(public_fonts.default, watermak_args[n].text, vec2_t(text_pos.x+text_add, text_pos.y), color(watermak_args[n].col.r, watermak_args[n].col.g, watermak_args[n].col.b, 255))
            text_add = text_add + render.get_text_size(public_fonts.default, watermak_args[n].text).x
        end
    end
end
cache.active_binds = {}
cache.bind_data = {}
cache.keybinds = {
    ["Double tap"] = menu.find("aimbot","general","exploits","doubletap","enable")[2],
    ["Hide shots"] = menu.find("aimbot","general","exploits","hideshots","enable")[2],
    ["Quick peek assist"] = menu.find("aimbot","general","misc","autopeek")[2],
    ["Dormant aimbot"] = menu.find("aimbot","general","dormant aimbot","enable")[2],
    ["Fake ping"] = menu.find("aimbot","general","fake ping","enable")[2],
    ["Fake duck"] = menu.find("antiaim","main","general","fakeduck")[2],
    ["Lock angle"] = menu.find("antiaim","main","general","lock angle")[2],
    ["Auto direction"] = menu.find("antiaim","main","auto direction","enable")[2],
    ["Extended angles"] = menu.find("antiaim","main","extended angles","enable")[2],
    ["Slow walk"] = menu.find("misc","main","movement","slow walk")[2],
    ["Edge jump"] = menu.find("misc","main","movement","edge jump")[2],
    ["Sneak"] = menu.find("misc","main","movement","sneak")[2],
    ["Edge bug helper"] = menu.find("misc","main","movement","edge bug helper")[2],
    ["Jump bug"] = menu.find("misc","main","movement","edge bug helper")[2],
    ["Fire extinguisher"] = menu.find("misc","utility","general","fire extinguisher")[2],
    ["Free cam"] = menu.find("misc","utility","general","freecam")[2],
    ["Nade helper"] = menu.find("misc","nade helper","general","enable")[2],
    ["Auto throw"] = menu.find("misc","nade helper","general","autothrow")[2],
    ["Anti aim"] = menu.find("antiaim","main","general","enable")[2],
    ["Aim bot"] = menu.find("aimbot","general","aimbot","enable")[2],
}
cache.bind_size = 160
function merge(table1,table2)
    local s = #table1
    for n, item in pairs(table2) do
        table1[n] = item
    end
    return table1
end
lua_render.keybinds = function()
    local rage_index = ragebot.get_active_cfg()
    local rage_weapons = {"auto","scout","awp","deagle","revolver","pistols","other"}
    local weapon = rage_weapons[rage_index+1]
    local dynamic_binds = {}
    if weapon~=nil then
        dynamic_binds = {
            ["Lethal shot"] = menu.find("aimbot",weapon,"target overrides","lethal shot")[2],
            ["Min. damage override"] = menu.find("aimbot",weapon,"target overrides","min. damage")[2],
            ["Hitbox override"] = menu.find("aimbot",weapon,"target overrides","hitbox")[2],
            ["Force safe point"] = menu.find("aimbot",weapon,"target overrides","safepoint")[2],
            ["Force body lean safe point"] = menu.find("aimbot",weapon,"target overrides","body lean safepoint")[2],
            ["Hitchance override"] = menu.find("aimbot",weapon,"target overrides","hitchance")[2],
        }
    end
    dynamic_binds = merge(dynamic_binds,cache.keybinds)
    local active_binds = 0
    for bind_name, bind in pairs(dynamic_binds) do
        bind_name = string.lower(bind_name)
        if not cache.bind_data[bind_name] then
            cache.bind_data[bind_name] = {
                inserted = false,
                alpha = 0,
                active = false,
            }
        end
        local mode = bind:get_mode()
        local is_valid = mode<3
        if is_valid then
            cache.bind_data[bind_name].active = bind:get()
            if cache.bind_data[bind_name].active and not cache.bind_data[bind_name].inserted then
                table.insert(cache.active_binds,{name=bind_name,mode=mode,ref=bind,active=true})
                cache.bind_data[bind_name].inserted = true
            elseif cache.bind_data[bind_name].inserted then
                for i, bind in ipairs(cache.active_binds) do
                    if bind.name==bind_name then
                        bind.mode = mode
                        bind.active = cache.bind_data[bind_name].active
                    end
                end
            end
        else
            cache.bind_data[bind_name].active = false
        end
        
        if cache.bind_data[bind_name].inserted then 
            active_binds = active_binds+7+cache.bind_data[bind_name].alpha/255*9
        else
            cache.bind_data[bind_name].alpha = 0
        end
    end
    local keybinds_size = 160
    local element = windows.keybind_list:render(active_binds>7,vec2_t(200,200),vec2_t(cache.bind_size,17+active_binds+13),false)
    element.alpha = math.max(element.alpha or 0,0)
    local pos = element.pos
    local alpha = element.alpha
    local size = element.size
    size.y = 17
    visual_element:render("keybind list",pos,vec2_t(pos.x+size.x,pos.y+size.y),alpha,active_binds+13)
    render.text(public_fonts.default, "keybinds", vec2_t(pos.x+size.x*0.5, pos.y+9), color(225, 225, 225, alpha),true)
    local removal = -1
    local bind_add = 0
    for n, bind in ipairs(cache.active_binds) do
        local info = cache.bind_data[bind.name]
        local modes = {"(toggle)","(hold on)","(hold off)"}
        local mode = modes[bind.mode+1]
        if not info.active and info.alpha<10 then
            removal = n
        end
        info.alpha = render.lerp(info.alpha,info.active and 255 or 0)
        local name_size = render.get_text_size(public_fonts.default, bind.name)
        render.text(public_fonts.default, bind.name, vec2_t(pos.x+6, pos.y+size.y+9+bind_add), color(215, 215, 215, info.alpha))
        local mode_size = render.get_text_size(public_fonts.default, mode)
        render.text(public_fonts.default, mode, vec2_t(pos.x+size.x-6-mode_size.x, pos.y+size.y+9+bind_add), color(215, 215, 215, info.alpha))
        if name_size.x+mode_size.x+40>keybinds_size then keybinds_size= name_size.x+mode_size.x+40 end
        bind_add=bind_add+7+info.alpha/255*9
        info.active = false
        cache.bind_data[bind.name] = info
    end
    if removal~=-1 then
        local name = cache.active_binds[removal].name
        cache.bind_data[name].alpha = 0
        cache.bind_data[name].inserted = false
        table.remove(cache.active_binds,removal)
    end
    cache.bind_size = render.lerp(cache.bind_size,keybinds_size)
end
lua_render.spectators = function()
end
lua_render.infopanel = function()
    
    local lp = entity_list.get_local_player()
    local screen = render.get_screen_size()
    local colors = {
        def = color(205,205,205),
        white = color(),
        orig = cache.visual_info["info panel"].color
    }
    local rage_index = (ragebot.get_active_cfg()+1) or 8
    local rage_weapons = {"auto","scout","awp","deagle","revolver","pistol","other"}
    local weapon = rage_weapons[rage_index] or "unknown"
    local info_panel_data = {
        {{"solitude.solutions ",colors.def}, {build_info.type,colors.orig} },
        {{"user: ",colors.def}, {build_info.user.name.."    ",colors.white}, {"weapon: ",colors.def},{lp and lp:is_valid() and lp:is_alive() and weapon or "unknown",colors.white} },
    }
    local element = windows.info_panel:render(true,vec2_t(200,screen.y*0.6),vec2_t(180,17+#info_panel_data*16+13),false)
    local pos = element.pos
    local alpha = element.alpha
    local size = element.size
    size.y = 17
    visual_element:render("info panel",pos,vec2_t(pos.x+size.x,pos.y+size.y),alpha,#info_panel_data*16+13)
    render.text(public_fonts.default, "info panel", vec2_t(pos.x+size.x*0.5, pos.y+8), color(215, 215, 215, alpha),true)
    for n, data in ipairs(info_panel_data) do
        local add = vec2_t(pos.x+6,pos.y+8+n*17)
        for i, arg in ipairs(data) do
            if arg.condition==nil or arg.condition then
                local text = arg[1] or arg
                local col = arg[2] or colors.def
                render.text(public_fonts.default, text, add, color(col.r, col.g, col.b, alpha))
                add.x = add.x + render.get_text_size(public_fonts.default, text).x
            end
        end
    end
end
lua_render.visual_elements = function()
    lua_render.clantag()
    if lua.misc.damageindicator:get()>1 then lua_render.damageindicator() end
    if lua.visuals.aimbotlogs:get(1) then lua_render.aimbotlogs() else lua_events = {} end
    local menu_windows = lua.visuals.elements:get()
    if menu_windows[1] then lua_render.watermark() end
    if menu_windows[2] then lua_render.keybinds() end
    if menu_windows[3] then lua_render.infopanel() end
end
callbacks.add(e_callbacks.PAINT, function()
    if not build_info.acces then
        if build_info.finalized then
            for tab_name, tab in pairs(gui.data) do
                for parent_name, parent in pairs(tab) do
                    for element_name, element in pairs(parent) do
                        element:set_visible(false)
                    end
                end
            end
        end
        return 0
    end
    lua_render.elements_visibility()
    lua_render.visual_elements()
    for id, hitmarker in pairs(cache.markers.data) do
        cache.markers.data[id].unrender = cache.markers.data[id].unrender+1
        if cache.markers.data[id].unrender>5 then
            cache.markers.data[id] = nil
        end
    end
end)
local menu_ref = {
    ragebot = {
        general = {
            exploits = {
                doubletap = {
                    enable = menu.find("aimbot","general","exploits","doubletap","enable")
                }
            }
        }
    },
    antiaim = {
        general = {
            enable = menu.find("antiaim","main","general","enable"),
            disable_states = menu.find("antiaim","main","general","disable states"),
            anti_knife = menu.find("antiaim","main","general","anti knife"),
            ladder_antiaim = menu.find("antiaim","main","general","ladder antiaim"),
            fast_ladder_move = menu.find("antiaim","main","general","fast ladder move"),
            fakeduck = menu.find("antiaim","main","general","fakeduck"),
            leg_slide = menu.find("antiaim","main","general","leg slide"),
            lock_angle = menu.find("antiaim","main","general","lock angle"),
        },
        manual = {
            left = menu.find("antiaim","main","manual","left"),
            back = menu.find("antiaim","main","manual","back"),
            right = menu.find("antiaim","main","manual","right"),
            disable_jitter = menu.find("antiaim","main","manual","disable jitter"),
            disable_rotate = menu.find("antiaim","main","manual","disable rotate"),
            invert_desync = menu.find("antiaim","main","manual","invert desync"),
            invert_body_lean = menu.find("antiaim","main","manual","invert body lean"),
        },
        angles = {
            pitch = menu.find("antiaim","main","angles","pitch"),
            yaw_base = menu.find("antiaim","main","angles","yaw base"),
            yaw_add = menu.find("antiaim","main","angles","yaw add"),
            rotate = menu.find("antiaim","main","angles","rotate"),
            rotate_range = menu.find("antiaim","main","angles","rotate range"),
            rotate_speed = menu.find("antiaim","main","angles","rotate speed"),
            jitter_mode = menu.find("antiaim","main","angles","jitter mode"),
            jitter_type = menu.find("antiaim","main","angles","jitter type"),
            jitter_add = menu.find("antiaim","main","angles","jitter add"),
            body_lean = menu.find("antiaim","main","angles","body lean"),
            body_lean_value = menu.find("antiaim","main","angles","body lean value"),
            moving_body_lean = menu.find("antiaim","main","angles","moving body lean"),
        },
        extended_angles = {
            enable = menu.find("antiaim","main","extended angles","enable"),
            enable_while_moving = menu.find("antiaim","main","extended angles","enable while moving"),
        },
        fakelag = {
            amount = menu.find("antiaim","main","fakelag","amount"),
            break_lag_compensation = menu.find("antiaim","main","fakelag","break lag compensation"),
        },
        desync = {
            stand = {
                side = menu.find("antiaim","main","desync","side#stand"),
                left_amount = menu.find("antiaim","main","desync","left amount#stand"),
                right_amount = menu.find("antiaim","main","desync","right amount#stand"),
            },
            move = {
                override_stand = menu.find("antiaim","main","desync","override stand#move"),
                side = menu.find("antiaim","main","desync","side#move"),
                left_amount = menu.find("antiaim","main","desync","left amount#move"),
                right_amount = menu.find("antiaim","main","desync","right amount#move"),
            },
            slow_walk = {
                override_stand = menu.find("antiaim","main","desync","override stand#slow walk"),
                side = menu.find("antiaim","main","desync","side#slow walk"),
                left_amount = menu.find("antiaim","main","desync","left amount#slow walk"),
                right_amount = menu.find("antiaim","main","desync","right amount#slow walk"),
            },
            anti_bruteforce = menu.find("antiaim","main","desync","anti bruteforce"),
            on_shot = menu.find("antiaim","main","desync","on shot"),
        }
    }
}
antiaim.ground_time = 0
antiaim.slow_walk = menu.find("misc","main","movement","slow walk")[2]
local fd_bind = menu.find("antiaim","main","general","fakeduck")[2]
antiaim.get_local_state = function(ctx)
    local lp = entity_list.get_local_player()
    if not lp or not lp:is_valid() or not lp:is_alive() then
        return 1
    end
    local lp_flags = lp:get_prop("m_fFlags")
    local ON_GROUND = bit.band(lp_flags, bit.lshift(1, 0)) == 1
    local IS_CROUCH = bit.band(lp_flags, bit.lshift(1, 1)) > 0 or fd_bind:get()
    local SPEED = lp:get_prop("m_vecVelocity"):length2d()
    if not ON_GROUND then
        antiaim.ground_time = 0
    else
        antiaim.ground_time = antiaim.ground_time+1
        if antiaim.ground_time>100 then antiaim.ground_time = 50 end
    end
    local state = 1
    if antiaim.ground_time>2 then
        if IS_CROUCH then
            state = 2
        else
            if SPEED<8 then
                state = 1
            else
                if antiaim.slow_walk:get() then
                    state = 3
                else
                    state = 4
                end
            end
        end
    else
        if IS_CROUCH then 
            state = 6
        else
            state = 5
        end
    end
    return state
end
local dt_bind = menu.find("aimbot","general","exploits","doubletap","enable")[2]
local w_dt = false
local w_exploiting = false
local explooit_ticks = {
    charge = 0,
    uncharge = 0
}
antiaim.get_exploit_state = function(ctx)
    local aa_mode = lua.antiaim.mode:get()
    local lp = entity_list.get_local_player()
    local m_iTeamNum = lp and lp:get_prop("m_iTeamNum")
    local menu_mode = aa_mode == 1 and aa_mode or m_iTeamNum
    local builder = {
        [8] = lua.antiaim.builder[menu_mode][8].main,
        [9] = lua.antiaim.builder[menu_mode][9].main,
    }
    local is_exploiting = exploits.get_charge()==14
    local was_exploiting = w_exploiting
    w_exploiting = is_exploiting
    local is_dt = dt_bind:get()
    local was_dt = w_dt
    w_dt = is_dt
    if builder[8].override:get() then
        if is_dt and (not is_exploiting or not was_exploiting) then
            explooit_ticks.charge = 4
        end
        if explooit_ticks.charge>0 then
            explooit_ticks.charge = explooit_ticks.charge -1
            explooit_ticks.uncharge = 0
            return 8
        end
    end
    if builder[9].override:get() then
        if not is_dt and (is_exploiting or was_exploiting) then
            explooit_ticks.uncharge = 17
        end
        if explooit_ticks.uncharge>0 then
            explooit_ticks.uncharge = explooit_ticks.uncharge -1
            explooit_ticks.charge = 0
            return 9
        end
    end
    return 0
end
antiaim.delay_ticks = 0
antiaim.sway = {
    yaw = 0,
    ticks = 0
}
antiaim.pitch_state = 0
antiaim.way_delay = 0

local spin_yaw = 0
local is_antibrute = false
local denfesive_ticks = 0
antiaim.execute = function(ctx)
    local total_elements = lua.antiaim.builder[antiaim.mode][antiaim.state]
    local builder_reference = total_elements.main
    local is_dt = menu_ref.ragebot.general.exploits.doubletap.enable[2]:get() or cache.keybinds["Hide shots"]:get()
    local is_exploiting = is_dt and exploits.get_charge()==exploits.get_max_charge()
    local is_doubletap = is_exploiting and menu_ref.ragebot.general.exploits.doubletap.enable[2]:get()
    local defensive_states = lua.antiaim.defensive:get()
    local menu_fl = menu_ref.antiaim.fakelag.amount:get()
    local choked_commands = engine.get_choked_commands()
    local is_defensive = is_doubletap and ((defensive_states[antiaim.local_state]) or (defensive_states[7] and cache.keybinds["Quick peek assist"]:get()) or (defensive_states[8] and cache.keybinds["Auto direction"]:get()))
    antiaim.antibrute[antiaim.state] = antiaim.antibrute[antiaim.state] or 0
    local anti_brute = {
        enable = antiaim.antibrute[antiaim.state]>0 and total_elements.main.antibrute:get(),
        customizeyaw = false,
        customizedesync = false
    }
    if anti_brute.enable then
        is_antibrute = true
        anti_brute.limit = total_elements.antibrute.limit:get()
        if antiaim.antibrute[antiaim.state]>anti_brute.limit then
            antiaim.antibrute[antiaim.state] = 1
        end
        anti_brute.state = antiaim.antibrute[antiaim.state]
        anti_brute.customizeyaw = total_elements.antibrute[anti_brute.state].customizeyaw:get()
        anti_brute.customizedesync = total_elements.antibrute[anti_brute.state].customizedesync:get()
    end
    local yawadd = 0
    local moddeg = 0
    local desync = {
        limit = 0,
        side = antiaim.bodyyaw
    }
    local auto_desync = true
    if anti_brute.customizedesync then
        builder_reference = total_elements.antibrute[anti_brute.state]
    end
    local desyncmode = builder_reference.bodyyaw:get()
    local desyncbreaker = builder_reference.desyncbreaker:get()
    builder_reference = total_elements.main
    if anti_brute.customizeyaw then
        builder_reference = total_elements.antibrute[anti_brute.state]
    end
    local yawmodifier = builder_reference.yawmodifier:get();
    local modifierdegree = builder_reference.modifierdegree:get()
    local spinspeed = builder_reference.spinspeed:get()
    local jitterdelay = builder_reference.jitterdelay.enable:get()
    local pitch = 1
    local menu_pitch = builder_reference.pitch:get()
    if is_defensive then
        if choked_commands==0 then denfesive_ticks = (denfesive_ticks+1)%4 end
        yawmodifier = 1
        if denfesive_ticks==0 then
            if choked_commands==0 then
                denfesive_ticks = 1
                yawmodifier = 7
                menu_pitch = lua.antiaim.defensive_pitch:get()
                modifierdegree = lua.antiaim.defensive_spin:get()
                spinspeed = lua.antiaim.defensive_spin_speed:get()*2
                desyncmode=1
            else
            end
        end
    end
    if menu_pitch<6 then
        pitch = menu_pitch
    elseif menu_pitch==6 then
        if choked_commands==0 then antiaim.pitch_state = (antiaim.pitch_state+1)%3 end
        local pitches = {2,4,3}
        pitch = pitches[antiaim.pitch_state+1]
    elseif menu_pitch==7 then
        pitch = math.random(2,4)
    end
    menu_ref.antiaim.angles.pitch:set(pitch)
    local delayticks = 1
    if jitterdelay==1 or yawmodifier==1 then
        delayticks = 1
    elseif jitterdelay==2 then
        delayticks = builder_reference.jitterdelay.global:get()
    elseif jitterdelay==3 then
        if yawmodifier<6 then
            if antiaim.bodyyaw then
                delayticks = builder_reference.jitterdelay.left:get()
            else
                delayticks = builder_reference.jitterdelay.right:get()
            end
        end
    end
    menu_ref.antiaim.angles.rotate:set(false)
    local waylimit = 1
    if yawmodifier==1 then

    elseif yawmodifier==2 then
        moddeg = math.random(-modifierdegree,modifierdegree)
    elseif yawmodifier==3 then
        moddeg = antiaim.bodyyaw and 0 or modifierdegree*2
    elseif yawmodifier==4 then
        moddeg = antiaim.bodyyaw and -modifierdegree or modifierdegree
    elseif yawmodifier==5 then--sway
        if choked_commands == 0 then 
            antiaim.sway.ticks = antiaim.sway.ticks+1
            if not is_exploiting and antiaim.local_state~=1 then
                if menu_fl>delayticks then
                    antiaim.sway.ticks = 0
                else
                    antiaim.sway.ticks = delayticks-2
                end
            end
            if antiaim.sway.ticks%delayticks==0 then
                antiaim.sway.ticks=0
                if is_exploiting then
                    antiaim.sway.yaw = (antiaim.sway.yaw+(antiaim.bodyyaw and 1 or -1)) 
                else
                    antiaim.sway.yaw = (antiaim.sway.yaw+(antiaim.bodyyaw and 4 or -4)) 
                end
            end
        end
        auto_desync = false
        local pct = {-modifierdegree,-modifierdegree*0.8,modifierdegree*0.8,modifierdegree}
        if antiaim.bodyyaw and antiaim.sway.yaw>(#pct-1) or not antiaim.bodyyaw and antiaim.sway.yaw<1 then
            antiaim.bodyyaw = not antiaim.bodyyaw
            if antiaim.sway.yaw>(#pct-1) then antiaim.sway.yaw = (#pct-1)
            elseif antiaim.sway.yaw<1 then antiaim.sway.yaw = 0 end
        end
        moddeg = pct[antiaim.sway.yaw+1]
    elseif yawmodifier==6 then
        local rand = math.random(2)
        auto_desync = false
        if desyncmode==2 then
            antiaim.bodyyaw = rand==1
        end
        moddeg = rand==1 and -modifierdegree or modifierdegree
    elseif yawmodifier==7 then
        local degree = math.abs(modifierdegree)
        local minus_degree = -degree
        local spin_speed = spinspeed/500
        if choked_commands==0 then 
            spin_yaw = normalize(spin_yaw+modifierdegree*spin_speed,minus_degree,degree)
        end
        moddeg = spin_yaw
    elseif yawmodifier==8 then
        waylimit = 3; 
        local delay = 1; if jitterdelay==2 then delay = delayticks elseif jitterdelay==3 then delay = builder_reference.jitterdelay[antiaim.waystate+1]:get() end
        if choked_commands==0 then 
            antiaim.way_delay = (antiaim.way_delay+1)%delay 
            if not is_exploiting and antiaim.local_state~=1 then
                if menu_fl>delay then
                    antiaim.way_delay = 0
                else
                    antiaim.way_delay = delay-2
                end
            end
            if antiaim.way_delay==0 then
                antiaim.waystate = antiaim.waystate+1
            end
        end
        antiaim.waystate = antiaim.waystate%waylimit
        local step = modifierdegree*2/(waylimit-1)
        moddeg = -modifierdegree+antiaim.waystate*step
        if builder_reference.xways.customways:get() then
            moddeg = builder_reference.xways[antiaim.waystate+1]:get()
        end
        if desyncbreaker and desyncmode==2 then
            desync.side = antiaim.waystate==0 or antiaim.waystate==(waylimit-1)
            auto_desync = false
        end
    elseif yawmodifier==9 then
        waylimit = 5; 
        local delay = 1; if jitterdelay==2 then delay = delayticks elseif jitterdelay==3 then delay = builder_reference.jitterdelay[antiaim.waystate+1]:get() end
        if choked_commands==0 then 
            antiaim.way_delay = (antiaim.way_delay+1)%delay 
            if not is_exploiting and antiaim.local_state~=1 then
                if menu_fl>delay then
                    antiaim.way_delay = 0
                else
                    antiaim.way_delay = delay-2
                end
            end
            if antiaim.way_delay==0 then
                antiaim.waystate = antiaim.waystate+1
            end
        end
        antiaim.waystate = antiaim.waystate%waylimit
        local step = modifierdegree*2/(waylimit-1)
        moddeg = -modifierdegree+antiaim.waystate*step
        if builder_reference.xways.customways:get() then
            moddeg = builder_reference.xways[antiaim.waystate+1]:get()
        end
        if desyncbreaker and desyncmode==2 then
            desync.side = antiaim.waystate==0 or antiaim.waystate==(waylimit-1)
            auto_desync = false
        end
    elseif yawmodifier==10 then
        waylimit = builder_reference.xways.limit:get(); 
        local delay = 1; if jitterdelay==2 then delay = delayticks elseif jitterdelay==3 then delay = builder_reference.jitterdelay[antiaim.waystate+1]:get() end
        if choked_commands==0 then 
            antiaim.way_delay = (antiaim.way_delay+1)%delay 
            if not is_exploiting and antiaim.local_state~=1 then
                if menu_fl>delay then
                    antiaim.way_delay = 0
                else
                    antiaim.way_delay = delay-2
                end
            end
            if antiaim.way_delay==0 then
                antiaim.waystate = antiaim.waystate+1
            end
        end
        antiaim.waystate = antiaim.waystate%waylimit
        local step = modifierdegree*2/(waylimit-1)
        moddeg = -modifierdegree+antiaim.waystate*step
        if builder_reference.xways.customways:get() then
            moddeg = builder_reference.xways[antiaim.waystate+1]:get()
        end
        if desyncbreaker and desyncmode==2 then
            desync.side = antiaim.waystate==0 or antiaim.waystate==(waylimit-1)
            auto_desync = false
        end
    end
    builder_reference = total_elements.main
    if anti_brute.customizedesync then
        builder_reference = total_elements.antibrute[anti_brute.state]
    end
    if desyncmode==1 then
        desync.limit = 0
    elseif desyncmode==2 then
        local desynclimit = builder_reference.desynclimit:get()
        desync.limit = math.abs(desynclimit)
        desync.side = desynclimit/desync.limit==-1
    elseif desyncmode==3 then
        if yawmodifier>7 and desyncbreaker then

        else
            desync.side = antiaim.bodyyaw
        end
        if desync.side then
            desync.limit = builder_reference.desyncleft:get()
        else
            desync.limit = builder_reference.desyncright:get()
        end
    end
    
    builder_reference = total_elements.main
    local yawmode = builder_reference.yawmode:get()
    if yawmode==1 then
        yawadd = builder_reference.yawadd:get()
    else
        if desync.side then
            yawadd = builder_reference.yawaddleft:get()
        else
            yawadd = builder_reference.yawaddright:get()
        end
    end
    
    if is_defensive then yawadd = 0; end
    local yawbase = lua.antiaim.yawbase:get()+1
    menu_ref.antiaim.angles.yaw_base:set(yawbase)
    if choked_commands==0 then 
        antiaim.delay_ticks = (antiaim.delay_ticks+1)%delayticks
        if not is_exploiting and antiaim.local_state~=1 then
            if menu_fl>delayticks then
                antiaim.delay_ticks = 0
            else
                antiaim.delay_ticks = delayticks-2
            end
        end
        if antiaim.delay_ticks == 0 then
            if auto_desync then
                antiaim.bodyyaw = not antiaim.bodyyaw
            end
        end
    end
    if is_exploiting and desync.limit==0 then
        menu_ref.antiaim.fakelag.amount:set(0)
        menu_ref.antiaim.fakelag.break_lag_compensation:set(false)
    else
        menu_ref.antiaim.fakelag.amount:set(lua.antiaim.fakelag:get())
        menu_ref.antiaim.fakelag.break_lag_compensation:set(lua.antiaim.breaklagcomp:get())
    end
    local yawdisablers = lua.antiaim.yawdisablers:get()
    local m_bWarmupPeriod = game_rules.get_prop("m_bWarmupPeriod")
    menu_ref.antiaim.general.disable_states:set(1,yawdisablers[2])
    menu_ref.antiaim.general.disable_states:set(2,yawdisablers[3])
    if yawdisablers[1] and m_bWarmupPeriod==1 then
        ctx:set_desync(0)
        local view_ang = engine.get_view_angles()
        ctx:set_yaw(view_ang.y)
        ctx:set_pitch(view_ang.x)
    end
    menu_ref.antiaim.general.anti_knife:set(true)
    menu_ref.antiaim.general.ladder_antiaim:set(false)
    menu_ref.antiaim.general.fast_ladder_move:set(true)
    menu_ref.antiaim.general.leg_slide:set(3)
    menu_ref.antiaim.angles.yaw_add:set(normalize(yawadd+moddeg,-180,180))
    menu_ref.antiaim.angles.jitter_mode:set(1)
    menu_ref.antiaim.angles.jitter_type:set(1)
    menu_ref.antiaim.angles.jitter_add:set(0)
    menu_ref.antiaim.desync.anti_bruteforce:set(false)
    menu_ref.antiaim.desync.on_shot:set(2)
    menu_ref.antiaim.desync.move.override_stand:set(false)
    menu_ref.antiaim.desync.slow_walk.override_stand:set(false)
    local percent_desync = desync.limit/0.6
    menu_ref.antiaim.desync.stand.left_amount:set(percent_desync)
    menu_ref.antiaim.desync.stand.right_amount:set(percent_desync)
    if desync.limit>0 then
        menu_ref.antiaim.desync.stand.side:set(desync.side and 2 or 3)
    else
        menu_ref.antiaim.desync.stand.side:set(1)
    end
end
antiaim.antibrute = {}
callbacks.add(e_callbacks.ANTIAIM,function(ctx)
    local lp = entity_list.get_local_player()
    if not lp or not lp:is_valid() or not lp:is_alive() then
        return 0
    end
    local m_iTeamNum = lp:get_prop("m_iTeamNum")
    local mode_aa = lua.antiaim.mode:get()
    antiaim.mode = mode_aa==1 and 1 or math.max(m_iTeamNum,2)
    antiaim.local_state = antiaim.get_local_state(ctx)
    antiaim.exploit_state = antiaim.get_exploit_state(ctx)
    if antiaim.exploit_state==0 then antiaim.state = lua.antiaim.builder[antiaim.mode][antiaim.local_state+1].main.override:get() and (antiaim.local_state+1) or 1 else antiaim.state = antiaim.exploit_state end
    if lua.antiaim.enable:get() then antiaim.execute(ctx) end
end)
cache.hitboxes = {'generic','head','chest','stomach','left arm','right arm','left leg','right leg','neck','gear'}
callbacks.add(e_callbacks.AIMBOT_HIT, function(shot)
    local colors = {
        def = color(205,205,205),
        white = color(),
        main = lua.visuals.aimbotlogs_color:get()
    }
    local text_args = {
        {text = "Hit",col = colors.def},
        {text = shot.player:get_name(),col = colors.main},
        {text = "in his",col = colors.def},
        {text = (cache.hitboxes[shot.hitgroup+1] or "unknown"),col = colors.main},
        {text = "for",col = colors.def},
        {text = tostring(shot.damage),col = colors.main},
        {text = "damage (",col = colors.def},
        {text = tostring(shot.player:get_prop("m_iHealth")),col = colors.main},
        {text = "hp left )",col = colors.def},
    }
    local logs = lua.visuals.aimbotlogs:get()[2]
    local total_text = ""
    local print_text = {}
    for n, arg in ipairs(text_args) do
        local arg = text_args[n]
        if n~=1 then total_text=total_text.." " end
        total_text = total_text..arg.text
        if logs then
            table.insert(print_text,color(arg.col.r, arg.col.g,arg.col.b))
            table.insert(print_text,arg.text)
        end
    end
    if logs then
        client.log(table.unpack(print_text))
    end
    client.create_log("hit",text_args,total_text,colors.main)
end)
callbacks.add(e_callbacks.AIMBOT_MISS, function(shot)
    local colors = {
        def = color(205,205,205),
        white = color(),
        main = lua.visuals.aimbotlogs_color:get()
    }
    local last_args = {}
    local miss_reason = shot.reason_string
    if miss_reason:find("%(")~=nil then
        miss_reason = miss_reason:sub(0,miss_reason:find("%(")-2)
    end
    if miss_reason=="spread" then
        last_args = {
            {text = tostring(shot.aim_hitchance).."%",col = colors.main},
            {text = "hit chance )",col = colors.def},
        }
    elseif miss_reason=="jitter" then
        local text = "safe"
        if not shot.aim_safepoint then text = "unsafe" end
        last_args = {
            {text = text,col = colors.main},
            {text = "shot )",col = colors.def},
        }
    else
        last_args = {
            {text = tostring(shot.backtrack_ticks),col = colors.main},
            {text = "back track )",col = colors.def},
        }
    end
    local text_args = {
        {text = "Missed",col = colors.def},
        {text = shot.player:get_name().."'s",col = colors.main},
        {text = (cache.hitboxes[shot.aim_hitgroup+1] or "unknown"),col = colors.main},
        {text = "due to",col = colors.def},
        {text = miss_reason,col = colors.main},
        {text = "(",col = colors.def},
        table.unpack(last_args)
    }
    local logs = lua.visuals.aimbotlogs:get()[2]
    local total_text = ""
    local print_text = {}
    for n, arg in ipairs(text_args) do
        local arg = text_args[n]
        if n~=1 then total_text=total_text.." " end
        total_text = total_text..arg.text
        if logs then
            table.insert(print_text,color(arg.col.r, arg.col.g,arg.col.b))
            table.insert(print_text,arg.text)
        end
    end
    if logs then
        client.log(table.unpack(print_text))
    end
    client.create_log("miss",text_args,total_text,colors.main)
end)
callbacks.add(e_callbacks.WORLD_HITMARKER, function(screen_pos, world_pos, alpha_factor, damage, is_lethal, is_headshot)
    local str_pos = tostring(world_pos.x)..tostring(world_pos.y)..tostring(world_pos.z)
    if cache.markers.data[str_pos]==nil and alpha_factor>0.1 then
        cache.markers.data[str_pos] = {
            pos = 0,
            unrender = 0
        }
    end
    if cache.markers.data[str_pos]~=nil then
        cache.markers.data[str_pos].unrender = 0
        cache.markers.data[str_pos].pos = cache.markers.data[str_pos].pos + 45*cache.frametime
        local alpha = alpha_factor*255
        local pos_add = 0
        if cache.markers.hit.v==2 then
            local line_size = 4
            render.line(vec2_t(screen_pos.x-line_size, screen_pos.y), vec2_t(screen_pos.x+line_size, screen_pos.y), color(cache.markers.hit.c.r,cache.markers.hit.c.g,cache.markers.hit.c.b,alpha))
            render.line(vec2_t(screen_pos.x, screen_pos.y-line_size), vec2_t(screen_pos.x, screen_pos.y+line_size), color(cache.markers.hit.c.r,cache.markers.hit.c.g,cache.markers.hit.c.b,alpha))
            pos_add = 7
        elseif cache.markers.hit.v==3 then
            local line_size = 4
            local line_spacing = 3
            render.line(vec2_t(screen_pos.x-line_spacing-line_size,screen_pos.y-line_spacing-line_size),vec2_t(screen_pos.x-line_spacing,screen_pos.y-line_spacing),color(cache.markers.hit.c.r,cache.markers.hit.c.g,cache.markers.hit.c.b,alpha))
            render.line(vec2_t(screen_pos.x+line_spacing+line_size,screen_pos.y-line_spacing-line_size),vec2_t(screen_pos.x+line_spacing,screen_pos.y-line_spacing),color(cache.markers.hit.c.r,cache.markers.hit.c.g,cache.markers.hit.c.b,alpha))
            render.line(vec2_t(screen_pos.x-line_spacing,screen_pos.y+line_spacing),vec2_t(screen_pos.x-line_spacing-line_size,screen_pos.y+line_spacing+line_size),color(cache.markers.hit.c.r,cache.markers.hit.c.g,cache.markers.hit.c.b,alpha))
            render.line(vec2_t(screen_pos.x+line_spacing,screen_pos.y+line_spacing),vec2_t(screen_pos.x+line_spacing+line_size,screen_pos.y+line_spacing+line_size),color(cache.markers.hit.c.r,cache.markers.hit.c.g,cache.markers.hit.c.b,alpha))
            pos_add = 11
        end
        if cache.markers.damage.v==2 then
            local screen_new_pos = render.world_to_screen(vec3_t(world_pos.x,world_pos.y,world_pos.z+cache.markers.data[str_pos].pos))
            render.text(public_fonts.marker.small, tostring(damage), vec2_t(screen_new_pos.x, screen_new_pos.y-pos_add - 4), color(cache.markers.damage.c.r,cache.markers.damage.c.g,cache.markers.damage.c.b,alpha),true)
        elseif cache.markers.damage.v==3 then
            render.text(public_fonts.marker.big, tostring(damage), vec2_t(screen_pos.x-1, screen_pos.y-pos_add - 6), color(cache.markers.damage.c.r,cache.markers.damage.c.g,cache.markers.damage.c.b,alpha),true)
        end
    end
end)
local jitter_legs = 0
callbacks.add(e_callbacks.ANTIAIM,function(ctx)
    local animations = lua.misc.localanimations:get()
    local groundlegs = lua.misc.groundlegs:get()
    local airlegs = lua.misc.airlegs:get()
    if animations[2] and antiaim.local_state>2 then
        ctx:set_render_animlayer(e_animlayers.LEAN,lua.misc.leanammount:get()*0.01,1)
    end
    if antiaim.local_state<5 then
        if animations[1] and antiaim.ground_time<40 then
            ctx:set_render_pose(e_poses.BODY_PITCH, 0.5)
        end
        if groundlegs==1 then
        elseif groundlegs==2 then
            ctx:set_render_pose(e_poses.STRAFE_DIR,0)
            ctx:set_render_pose(e_poses.MOVE_YAW,0)
        elseif groundlegs==3 then
            jitter_legs = (jitter_legs + 1)%3
            ctx:set_render_pose(e_poses.STRAFE_DIR,jitter_legs*0.5)
            ctx:set_render_pose(e_poses.MOVE_YAW,0)
        elseif groundlegs==4 then
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_MOVE, 0, 0)
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_STRAFECHANGE, 0, 1)
            ctx:set_render_pose(e_poses.STRAFE_DIR,0)
            ctx:set_render_pose(e_poses.MOVE_YAW,0)
        elseif groundlegs==5 then
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_STRAFECHANGE, 0, 1)
            ctx:set_render_pose(e_poses.STRAFE_DIR,0)
            ctx:set_render_pose(e_poses.MOVE_YAW,0)
        end
    else
        if airlegs==1 then
        elseif airlegs==2 then
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_JUMP_OR_FALL, 1, 1)
            ctx:set_render_pose(e_poses.STRAFE_DIR,0)
        elseif airlegs==3 then
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_JUMP_OR_FALL, 0, 1)
            ctx:set_render_pose(e_poses.STRAFE_DIR,0)
        elseif airlegs==4 then
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_JUMP_OR_FALL, 0, 0)
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_MOVE, 1, 1)
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_STRAFECHANGE, 1, 0)
            ctx:set_render_pose(e_poses.STRAFE_DIR,0)
            ctx:set_render_pose(e_poses.MOVE_YAW,0)
        elseif airlegs==5 then
            ctx:set_render_pose(e_poses.MOVE_BLEND_RUN,1)
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_MOVE, 1, 1)
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_STRAFECHANGE, 0, 1)
            ctx:set_render_pose(e_poses.STRAFE_DIR,0)
            ctx:set_render_pose(e_poses.MOVE_YAW,0)
        elseif airlegs==6 then
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_JUMP_OR_FALL, 0, 1)
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_MOVE, 1, -1)
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_STRAFECHANGE, 0, 1)
            ctx:set_render_pose(e_poses.RUN	,1)
            ctx:set_render_pose(e_poses.SPEED,1)
            ctx:set_render_pose(e_poses.MOVE_BLEND_RUN	,1)
            ctx:set_render_pose(e_poses.AIM_BLEND_STAND_RUN	,1)
        elseif airlegs==7 then
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_MOVE, 1, -1)
            ctx:set_render_animlayer(e_animlayers.MOVEMENT_STRAFECHANGE, 0, 1)
            ctx:set_render_pose(e_poses.RUN	,1)
            ctx:set_render_pose(e_poses.SPEED,1)
            ctx:set_render_pose(e_poses.JUMP_FALL,0)
            ctx:set_render_pose(e_poses.STRAFE_DIR,0)
            ctx:set_render_pose(e_poses.MOVE_YAW,0)
            ctx:set_render_pose(e_poses.MOVE_BLEND_RUN	,1)
            ctx:set_render_pose(e_poses.AIM_BLEND_STAND_RUN	,1)
        end
    end
end)
local in_antibrute = false
callbacks.add(e_callbacks.EVENT, function(event)
    if in_antibrute then return end
    local author = entity_list.get_player_from_userid(event.userid or 0)
    if not author or not author:is_valid() or not author:is_enemy() then 
        return 0 
    end
    local lp = entity_list.get_local_player()
    if not lp or not lp:is_valid() or not lp:is_alive() or lp:get_index()==author:get_index() or not author:is_enemy()  then
        return 0
    end
    local pos = vec3_t(event.x,event.y,event.z)
    local my_pos = lp:get_prop("m_vecOrigin")
    local diff = vec3_t(pos.x-my_pos.x,pos.y-my_pos.y,0):length()
    local height = pos.z - lp:get_eye_position().z
    if diff<80 and height>-5 and height<120 and lua.antiaim.builder[antiaim.mode][antiaim.state].main.antibrute:get() then
        in_antibrute = true
        client.delay_call(function()
            antiaim.antibrute[antiaim.state] = (antiaim.antibrute[antiaim.state] or 0)+1
            local colors = {
                def = color(205,205,205),
                white = color(),
                main = lua.visuals.aimbotlogs_color:get()
            }
            local text_args = {
                {text = "Anti brute",col = colors.def},
                {text = "changed",col = colors.main},
                {text = "due to",col = colors.def},
                {text = "player engagement",col = colors.main},
            }
            local logs = lua.visuals.aimbotlogs:get()[2]
            local total_text = ""
            local print_text = {}
            for n, arg in ipairs(text_args) do
                local arg = text_args[n]
                if n~=1 then total_text=total_text.." " end
                total_text = total_text..arg.text
                if logs then
                    table.insert(print_text,color(arg.col.r, arg.col.g,arg.col.b))
                    table.insert(print_text,arg.text)
                end
            end
            if logs then
                client.log(table.unpack(print_text))
            end
            client.create_log("anti brute",text_args,total_text,colors.main)
            in_antibrute = false
        end, 0.1)
    end
end, "bullet_impact")
callbacks.add(e_callbacks.EVENT, function(event)
    if is_antibrute then
        is_antibrute = false
        client.delay_call(function()
            local colors = {
                def = color(205,205,205),
                white = color(),
                main = lua.visuals.aimbotlogs_color:get()
            }
            local text_args = {
                {text = "Anti brute",col = colors.def},
                {text = "resetted",col = colors.main},
                {text = "due to",col = colors.def},
                {text = "new round",col = colors.main},
            }
            local logs = lua.visuals.aimbotlogs:get()[2]
            local total_text = ""
            local print_text = {}
            for n, arg in ipairs(text_args) do
                local arg = text_args[n]
                if n~=1 then total_text=total_text.." " end
                total_text = total_text..arg.text
                if logs then
                    table.insert(print_text,color(arg.col.r, arg.col.g,arg.col.b))
                    table.insert(print_text,arg.text)
                end
            end
            if logs then
                client.log(table.unpack(print_text))
            end
            client.create_log("anti brute",text_args,total_text,colors.main)
        end, 0.1)
    end
    antiaim.antibrute = {}
end, "round_start")