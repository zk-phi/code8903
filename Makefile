# ---- HINTER
HINTER = ttfautohint --no-info # Use ttfautohint (fast fuzzy hinting, requires an external tool)
# HINTER = fontforge ./scripts/Autohint.pe # Use fontforge (sharp hinting)
# HINTER = cp # Skip hinting

# ---- OPTIONS
JISZ8903OPTS  =
ROUNDEDMPOPTS =
MERGEOPTS     =

# ---- OUTPUT FILENAMES
SOURCE_JISZ8903  = ./fonts/JISZ8903-Medium.otf
SOURCE_ROUNDEDMP = ./fonts/rounded-mplus-1m-regular.ttf
# SOURCE_ROUNDEDMP = ./fonts/ryakFewRoundedSansserifR.ttf
TMP_JISZ8903     = ./tmp/JISZ8903-Medium_monospaced.ttf
TMP_ROUNDEDMP    = ./tmp/rounded-mplus-1m-regular_adjusted.ttf
UNHINTED_OUTPUT  = ./tmp/code8903-Medium_unhinted.ttf
HINTED_OUTPUT    = ./dist/code8903-Medium.ttf

all: $(HINTED_OUTPUT)
unhinted: $(UNHINTED_OUTPUT)
jisz8903: $(TMP_JISZ8903)
roundedmp: $(TMP_ROUNDEDMP)

$(HINTED_OUTPUT): $(UNHINTED_OUTPUT)
	$(HINTER) $(UNHINTED_OUTPUT) $(HINTED_OUTPUT)

$(UNHINTED_OUTPUT): ./scripts/code8903.pe $(TMP_JISZ8903) $(TMP_ROUNDEDMP)
	fontforge ./scripts/code8903.pe $(MERGEOPTS) $(TMP_JISZ8903) $(TMP_ROUNDEDMP) $(UNHINTED_OUTPUT)

$(TMP_JISZ8903): ./scripts/JISZ8903.pe $(SOURCE_JISZ8903)
	fontforge ./scripts/JISZ8903.pe $(JISZ8903OPTS) $(SOURCE_JISZ8903) $(TMP_JISZ8903)

$(TMP_ROUNDEDMP): ./scripts/RoundedMplus.pe $(SOURCE_ROUNDEDMP)
	fontforge ./scripts/RoundedMplus.pe $(ROUNDEDMPOPTS) $(SOURCE_ROUNDEDMP) $(TMP_ROUNDEDMP)

clean:
	rm ./tmp/*.ttf
	rm ./dist/*.ttf
