Shader "Custom/FurryPassoka" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
			_Distance("Distancia", Range(0, 10)) = 0.0
			_Tex("Aura Texture", 2D) = "white" {}
		_Pattern("Padrão da cor do fur", 2D) = "white" {}
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			Cull Back
			CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		half _Distance;
		fixed4 _Color;

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG

			Cull Back
			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows vertex:vert alpha

// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0

sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Tex;
			float2 uv_Pattern;
		};

		half _Glossiness;
		half _Metallic;
		half _Distance;
		fixed4 _Color;
		sampler2D _Tex;
		sampler2D _Pattern;

		void vert(inout appdata_full v) {
			v.vertex += (v.vertex + float4(v.normal, 1)) * _Distance;
		}

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_Pattern, IN.uv_Pattern) * _Color;
			o.Albedo = c;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = tex2D(_Tex, IN.uv_Tex).a;
		}
		ENDCGCull Back
			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows vertex:vert alpha

// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0

sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Tex;
			float2 uv_Pattern;
		};

		half _Glossiness;
		half _Metallic;
		half _Distance;
		fixed4 _Color;
		sampler2D _Tex;
		sampler2D _Pattern;

		void vert(inout appdata_full v) {
			v.vertex += (v.vertex + float4(v.normal, 1)) * _Distance * .8;
		}

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_Pattern, IN.uv_Pattern) * _Color;
			o.Albedo = c;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = tex2D(_Tex, IN.uv_Tex).a;
		}
		ENDCG
			Cull Back
			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows vertex:vert alpha

// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0

sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Tex;
			float2 uv_Pattern;
		};

		half _Glossiness;
		half _Metallic;
		half _Distance;
		fixed4 _Color;
		sampler2D _Tex;
		sampler2D _Pattern;

		void vert(inout appdata_full v) {
			v.vertex += (v.vertex + float4(v.normal, 1)) * _Distance * .6;
		}

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_Pattern, IN.uv_Pattern) * _Color;
			o.Albedo = c;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = tex2D(_Tex, IN.uv_Tex).a;
		}
		ENDCG
			Cull Back
			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows vertex:vert alpha

// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0

sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Tex;
			float2 uv_Pattern;
		};

		half _Glossiness;
		half _Metallic;
		half _Distance;
		fixed4 _Color;
		sampler2D _Tex;
		sampler2D _Pattern;

		void vert(inout appdata_full v) {
			v.vertex += (v.vertex + float4(v.normal, 1)) * _Distance * .4;
		}

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_Pattern, IN.uv_Pattern) * _Color;
			o.Albedo = c;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = tex2D(_Tex, IN.uv_Tex).a;
		}
		ENDCG
			Cull Back
			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows vertex:vert alpha

// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0

sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Tex;
			float2 uv_Pattern;
		};

		half _Glossiness;
		half _Metallic;
		half _Distance;
		fixed4 _Color;
		sampler2D _Tex;
		sampler2D _Pattern;

		void vert(inout appdata_full v) {
			v.vertex += (v.vertex + float4(v.normal, 1)) * _Distance * .2;
		}

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_Pattern, IN.uv_Pattern) * _Color;
			o.Albedo = c;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = tex2D(_Tex, IN.uv_Tex).a;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
