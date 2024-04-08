﻿Shader "Custom/Planet" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Atmosfera("Atmosfera", 2D) = "white" {}
		_Specular("Specular", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_NightTime("Night", 2D) = "white"{}
		_Normal("Normal", 2D) = "white"{}
		_Normal2("Normal2",2D) = "white"{}
	}
		SubShader{
			Tags { "RenderType" = "Transparent" }
			LOD 200

			CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows alpha

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 4.0

		sampler2D _MainTex;
	//
	sampler2D _Atmosfera;
	//
	sampler2D _Specular;
	//
	sampler2D _NightTime;
	//
	sampler2D _Normal;
	//
	sampler2D _Normal2;

	struct Input {
		float2 uv_MainTex;
		//
		float2 uv_Atmosfera;
		//
		INTERNAL_DATA
	};

	half _Glossiness;
	half _Metallic;
	fixed4 _Color;

	// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
	// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
	// #pragma instancing_options assumeuniformscaling
	UNITY_INSTANCING_BUFFER_START(Props)
		// put more per-instance properties here
	UNITY_INSTANCING_BUFFER_END(Props)

	void surf(Input IN, inout SurfaceOutputStandard o) {

		// Albedo comes from a texture tinted by color
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color ;
		o.Albedo = c.rgb;
		// Metallic and smoothness come from slider variables
		//o.Metallic = _Metallic;
		//o.Smoothness = tex2D(_Specular, IN.uv_MainTex);
		o.Smoothness = _Glossiness;
		//tex2D(_NightTime, IN.uv_MainTex)
		//o.Emission = WorldSpaceLightDir(float4(0,1,1,1));
		//o.Emission = tex2D(_NightTime, IN.uv_MainTex);
		o.Alpha = c.a;

		float3 worldNormal = WorldNormalVector(IN, o.Normal);
		float3 waterNormal = WorldNormalVector(IN, o.Normal);

		
		o.Normal = UnpackNormal(tex2D(_Normal, IN.uv_MainTex + _Time.x*0.5))*UnpackNormal(tex2D(_Normal2, -IN.uv_MainTex + _Time.x*0.5));


	}
	ENDCG
	}
		FallBack "Diffuse"
}
