Shader "Custom/DoublePass1" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Space("Space", Range(0,10)) = 0.0
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			Cull Front
			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows
			#pragma target 3.0
			sampler2D _MainTex;
			struct Input {
				float2 uv_MainTex;
			};
			fixed4 _Color;
			float _Space = 3.5;

			UNITY_INSTANCING_BUFFER_START(Props)
			UNITY_INSTANCING_BUFFER_END(Props)

			void surf(Input IN, inout SurfaceOutputStandard o) {
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
				o.Albedo = float3(1, 1, 0.1);
				o.Alpha = c.a;
			}
			ENDCG

			Cull Back
			CGPROGRAM
				#pragma surface surf Standard fullforwardshadows
				#pragma target 3.0
				sampler2D _MainTex;
				struct Input {
					float2 uv_MainTex;
				};
				fixed4 _Color;
				float _Space = 3.5;
				UNITY_INSTANCING_BUFFER_START(Props)
				UNITY_INSTANCING_BUFFER_END(Props)
					void surf(Input IN, inout SurfaceOutputStandard o) {
					fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
					//o.Albedo = c.rgb;
					o.Albedo = c * _Color;
				}
				ENDCG
					
					Cull Back
					CGPROGRAM
				#pragma surface surf Standard alpha fullforwardshadows alpha vertex:vert
				#pragma target 3.0
					sampler2D _MainTex;
				struct Input {
					float2 uv_MainTex;
				};
				fixed4 _Color;
				float _Space = 3.5;
				UNITY_INSTANCING_BUFFER_START(Props)
					UNITY_INSTANCING_BUFFER_END(Props)

				void vert(inout appdata_full v) 
				{
					v.vertex = v.vertex + float4(v.normal*_Space, 1);
				}
				void surf(Input IN, inout SurfaceOutputStandard o) {
					fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
					o.Albedo = c * _Color;
				}
				ENDCG

					Cull Back
					CGPROGRAM
				#pragma surface surf Standard alpha fullforwardshadows alpha vertex:vert
				#pragma target 3.0
					sampler2D _MainTex;
				struct Input {
					float2 uv_MainTex;
				};
				fixed4 _Color;
				float _Space = 3.5;
				UNITY_INSTANCING_BUFFER_START(Props)
					UNITY_INSTANCING_BUFFER_END(Props)

					void vert(inout appdata_full v)
				{
					v.vertex = v.vertex + float4(v.normal*(_Space+1), 1);
				}
				void surf(Input IN, inout SurfaceOutputStandard o) {
					fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
					o.Albedo = c * _Color;
				}
				ENDCG

					Cull Back
					CGPROGRAM
				#pragma surface surf Standard alpha fullforwardshadows alpha vertex:vert
				#pragma target 3.0
					sampler2D _MainTex;
				struct Input {
					float2 uv_MainTex;
				};
				fixed4 _Color;
				float _Space = 3.5;
				UNITY_INSTANCING_BUFFER_START(Props)
					UNITY_INSTANCING_BUFFER_END(Props)

					void vert(inout appdata_full v)
				{
					v.vertex = v.vertex + float4(v.normal*(_Space + 2), 1);
				}
				void surf(Input IN, inout SurfaceOutputStandard o) {
					fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
					o.Albedo = c * _Color;
				}
				ENDCG
		}
			FallBack "Diffuse"


}
