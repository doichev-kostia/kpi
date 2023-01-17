/**
 *
 * @type {import("postcss-preset-env").pluginOptions.features}
 */
const presetEnvOptions = {
	'nesting-rules': false,
};

module.exports = {
	plugins: {
		'postcss-preset-env': {
			features: presetEnvOptions,
		},
		'tailwindcss/nesting': {},
		tailwindcss: { config: './tailwind.config.cjs' },
		autoprefixer: {},
		...(process.env.NODE_ENV === 'production' ? { cssnano: {} } : {}),
	},
};
