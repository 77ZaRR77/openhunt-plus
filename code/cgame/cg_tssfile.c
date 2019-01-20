// Copyright (C) 2001 J. Hoffmann
//
// cg_tssfile -- file operations of the client part of the tactical support system
#include "cg_local.h"





static tss_strategy_t strategyFileBuf;

static tss_strategyStock_t strategyStock;
static int sortedStrategies[SSO_num_orders][TSS_MAX_STRATEGIES];
static int numStrategies[SSO_num_orders];
static int searchCompatibility[TSS_MAX_STRATEGIES];	// index is strategy id#
static char searchPattern[256];

static tss_strategy_t strategyPaletteBuf[TSS_MAX_STRATEGIES_PER_PALETTE];
static qboolean strategyPaletteBufUsed[TSS_MAX_STRATEGIES_PER_PALETTE];




#if TSSINCVAR
static void TSSFS_PackInstructions(const tss_instructions_t* i, tss_packedInstructions_t* pi) {
	int g;

	for (g = 0; g < MAX_GROUPS; g++) {
		pi->division[g].groupOrganization = i->groupOrganization[g];
		pi->division[g].minTotalMembers = i->division.group[g].minTotalMembers;
		pi->division[g].minAliveMembers = i->division.group[g].minAliveMembers;
		pi->division[g].minReadyMembers = i->division.group[g].minReadyMembers;
		pi->orders[g].missionAndMaxGuards = (i->orders.order[g].mission << 3) | (i->orders.order[g].maxGuards);
		pi->orders[g].maxDanger = i->orders.order[g].maxDanger;
		pi->orders[g].minReady = i->orders.order[g].minReady;
		pi->orders[g].minGroupSize = i->orders.order[g].minGroupSize;
	}
}
#endif

#if TSSINCVAR
static void TSSFS_UnpackInstructions(const tss_packedInstructions_t* pi, tss_instructions_t* i) {
	int g;
	int assignedPlayers;

	assignedPlayers = 0;
	for (g = 0; g < MAX_GROUPS; g++) {
		i->groupOrganization[g] = pi->division[g].groupOrganization;
		i->division.group[g].minTotalMembers = pi->division[g].minTotalMembers;
		assignedPlayers += i->division.group[g].minTotalMembers;
		i->division.group[g].minAliveMembers = pi->division[g].minAliveMembers;
		i->division.group[g].minReadyMembers = pi->division[g].minReadyMembers;
		i->orders.order[g].mission = pi->orders[g].missionAndMaxGuards >> 3;
		i->orders.order[g].maxGuards = pi->orders[g].missionAndMaxGuards & 7;
		i->orders.order[g].maxDanger = pi->orders[g].maxDanger;
		i->orders.order[g].minReady = pi->orders[g].minReady;
		i->orders.order[g].minGroupSize = pi->orders[g].minGroupSize;
	}
	i->division.unassignedPlayers = 100 - assignedPlayers;
}
#endif

#if TSSINCVAR
/*
static tss_packedPredicate_t TSSFS_PackPredicate(const tss_tacticalPredicate_t* tp) {
	tss_packedPredicate_t pp;

	pp = (tp->magnitude * TSSPROP_num_operators + tp->op) * 201 + tp->limit + 100;
	return pp;
}
*/
#endif

#if TSSINCVAR
/*
static void TSSFS_UnpackPredicate(tss_packedPredicate_t pp, tss_tacticalPredicate_t* tp) {
	int n;

	n = pp & 0xffff;	// Due to a bug in the compiler or assembler we can't define
						// 'tss_packedPredicate_t' as unsigned. So we're forced to this hack.

	tp->limit = (n % 201) - 100;
	n /= 201;
	tp->op = n % TSSPROP_num_operators;
	n /= TSSPROP_num_operators;
	tp->magnitude = pp;
}
*/
#endif

#if TSSINCVAR
static void TSSFS_PackDirective(const tss_directive_t* d, tss_packedDirective_t* pd) {
	int i, j;

	TSSFS_PackInstructions(&d->instr, &pd->instr);
	for (i = 0; i < TSS_CLAUSES_PER_OCCASION; i++) {
		for (j = 0; j < TSS_PREDICATES_PER_CLAUSE; j++) {
			pd->magnitudes[i][j] = d->occasion.clause[i].predicate[j].magnitude;
			pd->operators[i][j] = d->occasion.clause[i].predicate[j].op;
			pd->limits[i][j] = d->occasion.clause[i].predicate[j].limit;
			//pd->occasion[i][j] = TSSFS_PackPredicate(&d->occasion.clause[i].predicate[j]);
		}
	}
	Q_strncpyz(pd->name, d->name, sizeof(pd->name));
}
#endif

#if TSSINCVAR
static tss_tacticalMagnitude_t GetMagnitude(int m) {
	if (m < 0 || m >= TSSTM_num_magnitudes) m = TSSTM_no;
	return m;
}
#endif

#if TSSINCVAR
static tss_tacticalPredicate_operator_t GetOperator(int op) {
	if (op < 0 || op >= TSSPROP_num_operators) op = 0;
	return op;
}
#endif

#if TSSINCVAR
static int GetLimit(int limit) {
	if (limit < -100) limit = -100;
	if (limit > 100) limit = 100;
	return limit;
}
#endif

#if TSSINCVAR
static void TSSFS_UnpackDirective(const tss_packedDirective_t* pd, tss_directive_t* d) {
	int i, j;

	TSSFS_UnpackInstructions(&pd->instr, &d->instr);
	for (i = 0; i < TSS_CLAUSES_PER_OCCASION; i++) {
		for (j = 0; j < TSS_PREDICATES_PER_CLAUSE; j++) {
			d->occasion.clause[i].predicate[j].magnitude = GetMagnitude(pd->magnitudes[i][j]);
			d->occasion.clause[i].predicate[j].op = GetOperator(pd->operators[i][j]);
			d->occasion.clause[i].predicate[j].limit = GetLimit(pd->limits[i][j]);
			//TSSFS_UnpackPredicate(pd->occasion[i][j], &d->occasion.clause[i].predicate[j]);
		}
	}
	Q_strncpyz(d->name, pd->name, sizeof(d->name));
}
#endif

#if TSSINCVAR
static tss_packedOccasionClauseUseFlags_t TSSFS_PackFlags(const tss_directive_t* d) {
	tss_packedOccasionClauseUseFlags_t f;
	int i;

	f = 0;
	for (i = 0; i < TSS_CLAUSES_PER_OCCASION; i++) {
		if (!d->occasion.clause[i].inUse) continue;

		f |= 1 << i;
	}

	if (d->inUse) f |= TSS_PACKED_OCCASION_FLAGS_DIRECTIVE_USED;

	return f;
}
#endif

#if TSSINCVAR
static void TSSFS_UnpackFlags(tss_packedOccasionClauseUseFlags_t f, tss_directive_t* d) {
	int i;

	for (i = 0; i < TSS_CLAUSES_PER_OCCASION; i++) {
		d->occasion.clause[i].inUse = (f & (1 << i))? qtrue : qfalse;
	}
	d->inUse = (f & TSS_PACKED_OCCASION_FLAGS_DIRECTIVE_USED)? qtrue : qfalse;
}
#endif

#if TSSINCVAR
static void TSSFS_PackStrategy(const tss_strategy_t* s, tss_packedStrategy_t* ps) {
	int i;

	memset(ps, 0, sizeof(*ps));

	memcpy(ps->id, s->id, sizeof(s->id));
	ps->version = s->version;
	ps->gametype = s->gametype;
	memcpy(ps->generic, s->generic, sizeof(s->generic));
	memcpy(ps->name, s->name, sizeof(s->name));
	memcpy(ps->comment, s->comment, sizeof(s->comment));
	ps->autoCondition = s->autoCondition;
	ps->rfa_dangerLimit = s->rfa_dangerLimit;
	ps->rfd_dangerLimit = s->rfd_dangerLimit;
	ps->short_term = s->short_term;
	ps->medium_term = s->medium_term;
	ps->long_term = s->long_term;

	TSSFS_PackInstructions(&s->directives[0].instr, &ps->defaultInstructions);

	for (i = 0; i < TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY; i++) {
		TSSFS_PackDirective(&s->directives[i + 1], &ps->nonDefaultDirectives[i]);
		ps->nonDefaultDirectivesFlags[i] = TSSFS_PackFlags(&s->directives[i + 1]);
	}
}
#endif

static void CG_TSS_CorrectName(char* name, int size) {
	for (; size-- > 0 && *name != 0; name++) {
		if (*name >= 32) continue;

		*name = '_';
	}
}

#if TSSINCVAR
static void TSSFS_MakeStrategyValid(tss_strategy_t* strategy) {
	int i;

	strategy->directives[0].inUse = qtrue;
	memset(&strategy->directives[0].name, 0, TSS_NAME_SIZE);
	strcpy(strategy->directives[0].name, "default");
	memset(&strategy->directives[0].occasion, 0, sizeof(tss_occasion_t));
	for (i = 0; i < TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY+1; i++) {
		int g, n;
		char groupUsed[16];

		CG_TSS_CorrectName(strategy->directives[i].name, TSS_NAME_SIZE);

		n = 0;
		for (g = 0; g < MAX_GROUPS; g++) {
			n += strategy->directives[i].instr.division.group[g].minTotalMembers;
		}
		if (n < 0 || n > 100) {
			for (g = 0; g < MAX_GROUPS; g++) {
				strategy->directives[i].instr.division.group[g].minTotalMembers = 0;
			}
		}
		else {
			strategy->directives[i].instr.division.unassignedPlayers = 100 - n;
		}

		memset(groupUsed, 0, sizeof(groupUsed));
		for (g = 0; g < MAX_GROUPS; g++) {
			n = strategy->directives[i].instr.groupOrganization[g];
			if (n < 0) break;
			if (n >= MAX_GROUPS) break;
			if (groupUsed[n]) break;

			groupUsed[n] = qtrue;
		}
		if (g < MAX_GROUPS) {
			for (g = 0; g < MAX_GROUPS; g++) {
				strategy->directives[i].instr.groupOrganization[g] = g;
			}
		}
	}
}
#endif

#if TSSINCVAR
static void TSSFS_UnpackStrategy(const tss_packedStrategy_t* ps, tss_strategy_t* s) {
	int i;

	memset(s, 0, sizeof(*s));

	memcpy(s->id, ps->id, sizeof(ps->id));
	s->version = ps->version;
	s->gametype = ps->gametype;
	memcpy(s->generic, ps->generic, sizeof(s->generic));
	memcpy(s->name, ps->name, sizeof(ps->name));
	s->name[TSS_NAME_SIZE-1] = 0;
	memcpy(s->comment, ps->comment, sizeof(s->comment));
	s->comment[63] = 0;
	s->autoCondition = ps->autoCondition? qtrue : qfalse;
	s->rfa_dangerLimit = GetLimit(ps->rfa_dangerLimit);
	s->rfd_dangerLimit = GetLimit(ps->rfd_dangerLimit);
	s->short_term = ps->short_term;
	if (s->short_term < 0) s->short_term = 0;
	if (s->short_term > 100) s->short_term = 100;
	s->medium_term = ps->medium_term;
	if (s->medium_term < 0) s->medium_term = 0;
	if (s->medium_term > 100) s->medium_term = 100;
	s->long_term = ps->long_term;
	if (s->long_term < 0) s->long_term = 0;
	if (s->long_term > 100) s->long_term = 100;

	TSSFS_UnpackInstructions(&ps->defaultInstructions, &s->directives[0].instr);

	for (i = 0; i < TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY; i++) {
		TSSFS_UnpackDirective(&ps->nonDefaultDirectives[i], &s->directives[i + 1]);
		TSSFS_UnpackFlags(ps->nonDefaultDirectivesFlags[i], &s->directives[i + 1]);
	}

	TSSFS_MakeStrategyValid(s);
}
#endif

#if TSSINCVAR
static int TSSFS_CodeTriplet(const unsigned char* input, int size, unsigned char** output) {
	int t1, t2, t3;
	int len;

	len = 3;
	if (len > size) len = size;
	t1 = t2 = t3 = 0;
	if (size > 0) t1 = input[0];
	if (size > 1) t2 = input[1];
	if (size > 2) t3 = input[2];

	if (t1 == 0 && t2 == 0 && t3 == 0) {
		int i;

		len = 4095 + 64 + 9;
		if (len > size) len = size;
		for (i = 3; i < len; i++) if (input[i]) break;
		len = i;
		switch (len) {
		case 3:
			(*output)[0] = '!';
			*output += 1;
			break;
		case 4:
			(*output)[0] = '?';
			*output += 1;
			break;
		case 5:
			(*output)[0] = '(';
			*output += 1;
			break;
		case 6:
			(*output)[0] = ')';
			*output += 1;
			break;
		case 7:
			(*output)[0] = '[';
			*output += 1;
			break;
		case 8:
			(*output)[0] = ']';
			*output += 1;
			break;
		default:
			if (len < 64 + 9) {
				(*output)[0] = '*';
				(*output)[1] = TSS_CodeNibble(len - 9);
				*output += 2;
			}
			else {
				t1 = len - (64 + 9);
				(*output)[0] = '=';
				(*output)[1] = TSS_CodeNibble(t1 >> 6);
				(*output)[2] = TSS_CodeNibble(t1);
				*output += 3;
			}
			break;
		}
	}
	else {
		(*output)[0] = TSS_CodeNibble(t1);
		(*output)[1] = TSS_CodeNibble((t1 >> 6) + (t2 << 2));
		(*output)[2] = TSS_CodeNibble((t2 >> 4) + (t3 << 4));
		(*output)[3] = TSS_CodeNibble(t3 >> 2);
		*output += 4;
	}
	return len;
}
#endif

#if TSSINCVAR
static int TSSFS_DecodeTriplet(const unsigned char** input, unsigned char* output, int size) {
	int t1, t2, t3, t4;
	int len;
	int numZero;

	t1 = t2 = t3 = t4 = 0;

	switch ((*input)[0]) {
	case 0:
		return -1;
	case '!':
		numZero = 3;
		*input += 1;
		break;
	case '?':
		numZero = 4;
		*input += 1;
		break;
	case '(':
		numZero = 5;
		*input += 1;
		break;
	case ')':
		numZero = 6;
		*input += 1;
		break;
	case '[':
		numZero = 7;
		*input += 1;
		break;
	case ']':
		numZero = 8;
		*input += 1;
		break;
	case '*':
		numZero = TSS_DecodeNibble((*input)[1]) + 9;
		*input += 2;
		break;
	case '=':
		t1 = TSS_DecodeNibble((*input)[1]);
		t2 = TSS_DecodeNibble((*input)[2]);
		*input += 3;
		numZero = (t1 << 6) + t2 + 64 + 9;
		break;
	default:
		numZero = 0;
		t1 = TSS_DecodeNibble((*input)[0]);
		t2 = TSS_DecodeNibble((*input)[1]);
		t3 = TSS_DecodeNibble((*input)[2]);
		t4 = TSS_DecodeNibble((*input)[3]);
		*input += 4;
		break;
	}

	if (numZero > 0) {
		int i;

		len = numZero;
		if (len > size) len = size;
		for (i = 0; i < len; i++) {
			output[i] = 0;
		}
	}
	else {
		len = 0;
		if (size > 0) {
			output[0] = t1 + ((t2 & 3) << 6);
			len++;
		}
		if (size > 1) {
			output[1] = (t2 >> 2) + ((t3 & 15) << 4);
			len++;
		}
		if (size > 2) {
			output[2] = (t3 >> 4) + (t4 << 2);
			len++;
		}
	}
	return len;
}
#endif

#if TSSINCVAR
static int TSSFS_CodeBuf(const char* input, int inputSize, char* output, int maxOutputSize) {
	unsigned char* outputPtr;
	unsigned char* outputEnd;
	int codedSize;

	outputPtr = (unsigned char*) output;
	outputEnd = outputPtr + maxOutputSize - 3;
	codedSize = 0;
	while (inputSize > 0 && outputPtr < outputEnd) {
		int n;

		n = TSSFS_CodeTriplet((const unsigned char*)input, inputSize, &outputPtr);
		input += n;
		inputSize -= n;
		codedSize += n;
	}
	*outputPtr = 0;
	return codedSize;
}
#endif

#if TSSINCVAR
static int TSSFS_DecodeBuf(const char* input, char* output, int size) {
	int inputLen;
	int outputLen;
	const unsigned char* inputPtr;
	const unsigned char* inputEnd;

	inputLen = strlen(input);
	if (inputLen <= 0) return -1;
	inputPtr = (const unsigned char*) input;
	inputEnd = inputPtr + inputLen;
	outputLen = 0;
	while (inputPtr < inputEnd && size > 0) {
		int len;

		len = TSSFS_DecodeTriplet(&inputPtr, (unsigned char*)output, size);
		if (len < 0) break;

		output += len;
		size -= len;

		outputLen += len;
	}
	return outputLen;
}
#endif

#if TSSINCVAR
static qboolean TSSFS_DumpBufferToFile(const char* filename, const char* base, const void* buffer, int size) {
	fileHandle_t file;
	int count;
	const char* inputPtr;
	char dataBuf[MAX_INFO_STRING];
	char outputBuf[MAX_INFO_STRING];

	trap_FS_FOpenFile(filename, &file, FS_WRITE);
	if (!file) {
		CG_Printf(S_COLOR_RED "could not write to %s\n", filename);
		return qfalse;
	}

	count = 0;
	inputPtr = (const char*) buffer;
	while (size > 0) {
		int len;

		len = TSSFS_CodeBuf(inputPtr, size, dataBuf, 1000);
		Com_sprintf(outputBuf, sizeof(outputBuf), "%s%d %s\n", base, count, dataBuf);
		trap_FS_Write(outputBuf, strlen(outputBuf), file);

		inputPtr += len;
		size -= len;
		count++;
	}
	trap_FS_FCloseFile(file);
	return qtrue;
}
#endif

#if TSSINCVAR
static void TSSFS_DumpBufferToCvars(const char* base, const void* buffer, int size) {
	int count;
	const char* inputPtr;
	char dataBuf[MAX_INFO_STRING];
	char cvarname[32];

	count = 0;
	inputPtr = (const char*) buffer;
	while (size > 0) {
		int len;

		len = TSSFS_CodeBuf(inputPtr, size, dataBuf, 1000);
		Com_sprintf(cvarname, sizeof(cvarname), "%s%d", base, count);
		trap_Cvar_Register(NULL, cvarname, "", CVAR_ROM);
		trap_Cvar_Set(cvarname, dataBuf);

		inputPtr += len;
		size -= len;
		count++;
	}
	Com_sprintf(cvarname, sizeof(cvarname), "%s%d", base, count);
	trap_Cvar_Register(NULL, cvarname, "", CVAR_ROM);
	trap_Cvar_Set(cvarname, "");
}
#endif

#if TSSINCVAR
static int TSSFS_CollectCVarData(const char* base, void* buffer, int size) {
	int count;
	int totalLen;
	char* outputPtr;
	char data[MAX_INFO_STRING];

	count = 0;
	totalLen = 0;
	outputPtr = (char*) buffer;
	while (size > 0) {
		int len;

		memset(data, 0, sizeof(data));
		trap_Cvar_VariableStringBuffer(va("%s%d", base, count), data, sizeof(data) - 4);
		len = TSSFS_DecodeBuf(data, outputPtr, size);
		if (len < 0) break;
		outputPtr += len;
		totalLen += len;
		size -= len;
		count++;
	}
	return totalLen;
}
#endif

#if TSSINCVAR
qboolean TSSFS_SaveStrategy(const char* filename, const char* cvarbase, const tss_strategy_t* strategy) {
	tss_packedStrategy_t packedStrategy;

	TSSFS_PackStrategy(strategy, &packedStrategy);
	TSSFS_DumpBufferToCvars(cvarbase, &packedStrategy, sizeof(packedStrategy));
	if (!TSSFS_DumpBufferToFile(va("tss/%s", filename), "tssdata ", &packedStrategy, sizeof(packedStrategy))) return qfalse;
	return qtrue;
}
#endif

#if TSSINCVAR
qboolean TSSFS_LoadStrategy(const char* cvarBase, tss_strategy_t* strategy) {
	tss_packedStrategy_t packedStrategy;
	int size;

	size = TSSFS_CollectCVarData(cvarBase, &packedStrategy, sizeof(packedStrategy));
	if (size < sizeof(packedStrategy)) return qfalse;
	TSSFS_UnpackStrategy(&packedStrategy, strategy);
	return qtrue;
}
#endif

#if TSSINCVAR
static qboolean TSSFS_GetPackedStrategyHeader(const char* cvarBase, tss_packedStrategyHeader_t* header) {
	int size;

	size = TSSFS_CollectCVarData(cvarBase, header, sizeof(*header));
	if (size < sizeof(*header)) return qfalse;
	header->name[TSS_NAME_SIZE-1] = 0;
	return qtrue;
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetString(char* str, int size) {
	memcpy(str, strategyFileBufPos, size);
	str[size-1] = 0;
	strategyFileBufPos += size;
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutString(const char* str, int size) {
	memcpy(strategyFileBufPos, str, size);
	strategyFileBufPos += size;
}
#endif

#if !TSSINCVAR
static int CG_TSS_GetInt(int minimum, int maximum) {
	long n;

	n =
		(strategyFileBufPos[0] << 24) +
		(strategyFileBufPos[1] << 16) +
		(strategyFileBufPos[2] <<  8) +
		(strategyFileBufPos[3]      );
	strategyFileBufPos += 4;
	if (minimum != 0 || maximum != 0) {
		if (n < minimum) n = minimum;
		if (n > maximum) n = maximum;
	}
	return n;
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutInt(int n) {
	strategyFileBufPos[0] = (n >> 24) & 255;
	strategyFileBufPos[1] = (n >> 16) & 255;
	strategyFileBufPos[2] = (n >>  8) & 255;
	strategyFileBufPos[3] = (n      ) & 255;
	strategyFileBufPos += 4;
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetPredicate(tss_tacticalPredicate_t* predicate) {
	predicate->magnitude = CG_TSS_GetInt(0, TSSTM_num_magnitudes-1);
	predicate->op = CG_TSS_GetInt(0, TSSPROP_num_operators);
	predicate->limit = CG_TSS_GetInt(-100, 100);
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutPredicate(const tss_tacticalPredicate_t* predicate) {
	CG_TSS_PutInt(predicate->magnitude);
	CG_TSS_PutInt(predicate->op);
	CG_TSS_PutInt(predicate->limit);
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetClause(tss_clause_t* clause) {
	int i;

	clause->inUse = CG_TSS_GetInt(0, 1);
	for (i = 0; i < TSS_PREDICATES_PER_CLAUSE; i++) {
		CG_TSS_GetPredicate(&clause->predicate[i]);
	}
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutClause(const tss_clause_t* clause) {
	int i;

	CG_TSS_PutInt(clause->inUse);
	for (i = 0; i < TSS_PREDICATES_PER_CLAUSE; i++) {
		CG_TSS_PutPredicate(&clause->predicate[i]);
	}
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetOccasion(tss_occasion_t* occasion) {
	int i;

	for (i = 0; i < TSS_CLAUSES_PER_OCCASION; i++) {
		CG_TSS_GetClause(&occasion->clause[i]);
	}
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutOccasion(const tss_occasion_t* occasion) {
	int i;

	for (i = 0; i < TSS_CLAUSES_PER_OCCASION; i++) {
		CG_TSS_PutClause(&occasion->clause[i]);
	}
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetGroupMembers(tss_group_members_t* group) {
	group->minTotalMembers = CG_TSS_GetInt(0, 100);
	group->minAliveMembers = CG_TSS_GetInt(0, 100);
	group->minReadyMembers = CG_TSS_GetInt(0, 100);
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutGroupMembers(const tss_group_members_t* group) {
	CG_TSS_PutInt(group->minTotalMembers);
	CG_TSS_PutInt(group->minAliveMembers);
	CG_TSS_PutInt(group->minReadyMembers);
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetDivision(tss_division_t* division) {
	int i;

	division->unassignedPlayers = CG_TSS_GetInt(0, 100);
	for (i = 0; i < MAX_GROUPS; i++) {
		CG_TSS_GetGroupMembers(&division->group[i]);
	}
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutDivision(const tss_division_t* division) {
	int i;

	CG_TSS_PutInt(division->unassignedPlayers);
	for (i = 0; i < MAX_GROUPS; i++) {
		CG_TSS_PutGroupMembers(&division->group[i]);
	}
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetOrder(tss_order_t* order) {
	order->mission = CG_TSS_GetInt(0, TSSMISSION_num_missions);
	order->maxDanger = CG_TSS_GetInt(-100, 100);
	order->minReady = CG_TSS_GetInt(0, 100);
	order->minGroupSize = CG_TSS_GetInt(0, 100);
	order->maxGuards = CG_TSS_GetInt(0, 100);
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutOrder(const tss_order_t* order) {
	CG_TSS_PutInt(order->mission);
	CG_TSS_PutInt(order->maxDanger);
	CG_TSS_PutInt(order->minReady);
	CG_TSS_PutInt(order->minGroupSize);
	CG_TSS_PutInt(order->maxGuards);
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetOrders(tss_orders_t* orders) {
	int i;

	for (i = 0; i < MAX_GROUPS; i++) {
		CG_TSS_GetOrder(&orders->order[i]);
	}
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutOrders(const tss_orders_t* orders) {
	int i;

	for (i = 0; i < MAX_GROUPS; i++) {
		CG_TSS_PutOrder(&orders->order[i]);
	}
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetInstructions(tss_instructions_t* instructions) {
	CG_TSS_GetString(instructions->groupOrganization, sizeof(instructions->groupOrganization));
	CG_TSS_GetDivision(&instructions->division);
	CG_TSS_GetOrders(&instructions->orders);
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutInstructions(const tss_instructions_t* instructions) {
	CG_TSS_PutString(instructions->groupOrganization, sizeof(instructions->groupOrganization));
	CG_TSS_PutDivision(&instructions->division);
	CG_TSS_PutOrders(&instructions->orders);
}
#endif

#if !TSSINCVAR
static void CG_TSS_GetDirective(tss_directive_t* directive) {
	directive->inUse = CG_TSS_GetInt(0, 1);
	CG_TSS_GetString(directive->name, sizeof(directive->name));
	CG_TSS_CorrectName(directive->name, sizeof(directive->name));
	CG_TSS_GetOccasion(&directive->occasion);
	CG_TSS_GetInstructions(&directive->instr);
}
#endif

#if !TSSINCVAR
static void CG_TSS_PutDirective(const tss_directive_t* directive) {
	CG_TSS_PutInt(directive->inUse);
	CG_TSS_PutString(directive->name, sizeof(directive->name));
	CG_TSS_PutOccasion(&directive->occasion);
	CG_TSS_PutInstructions(&directive->instr);
}
#endif

#if !TSSINCVAR
qboolean CG_TSS_LoadStrategy(const char* filename, tss_strategy_t* strategy) {
	int len;
	fileHandle_t f;
	int version;
	int i;
	qboolean ok;

	ok = qfalse;

	len = trap_FS_FOpenFile(filename, &f, FS_READ);
	if (!f) {
		CG_Printf(S_COLOR_RED "strategy file not found: %s\n", filename);
		goto Exit;
	}
	if (len < 8) {
		CG_Printf(S_COLOR_RED "invalid strategy file: %s\n", filename);
		goto Exit;
	}
	
	strategyFileBufPos = (unsigned char*) &strategyFileBuf;
	trap_FS_Read(strategyFileBufPos, 8, f);
	if (Q_strncmp(strategyFileBuf.id, "HUNT", 4)) {
		CG_Printf(S_COLOR_RED "invalid Hunt strategy file: %s\n", filename);
		goto Exit;
	}
	strategyFileBufPos += 4;
	version = CG_TSS_GetInt(0, 0);
	if (version != TSS_STRATEGY_VERSION) {
		CG_Printf(S_COLOR_RED "wrong version, expected %d, found %d in %s\n", TSS_STRATEGY_VERSION, version, filename);
		goto Exit;
	}
	if (len != sizeof(tss_strategy_t)) {
		CG_Printf(S_COLOR_RED "invalid strategy file size: %s\n", filename);
		goto Exit;
	}

	trap_FS_Read(strategyFileBufPos, sizeof(tss_strategy_t) - 8, f);

	

	strategyFileBufPos = (unsigned char*) &strategyFileBuf;

	memcpy(strategy->id, strategyFileBufPos, sizeof(strategy->id));
	strategyFileBufPos += sizeof(strategy->id);
	strategy->version = CG_TSS_GetInt(0, 0);
	strategy->gametype = CG_TSS_GetInt(0, 0);
	CG_TSS_GetString(strategy->generic, sizeof(strategy->generic));
	CG_TSS_GetString(strategy->name, sizeof(strategy->name));
	CG_TSS_GetString(strategy->comment, sizeof(strategy->comment));
	strategy->autoCondition = CG_TSS_GetInt(0, 1);
	strategy->rfa_dangerLimit = CG_TSS_GetInt(-100, 100);
	strategy->rfd_dangerLimit = CG_TSS_GetInt(-100, 100);
	strategy->short_term = CG_TSS_GetInt(0, 100);
	strategy->medium_term = CG_TSS_GetInt(0, 100);
	strategy->long_term = CG_TSS_GetInt(0, 100);

	for (i = 0; i < TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY+1; i++) {
		CG_TSS_GetDirective(&strategy->directives[i]);
	}



	if (strategy->gametype != cg.tssGametype) {
		CG_Printf(S_COLOR_RED "wrong gametype in strategy file: %s\n", filename);
		CG_Printf(S_COLOR_RED "found '%d', expected '%d'\n", strategy->gametype, cg.tssGametype);
		goto Exit;
	}

	// now correct some things that might be corrupted
	strategy->directives[0].inUse = qtrue;
	memset(&strategy->directives[0].name, 0, TSS_NAME_SIZE);
	strcpy(strategy->directives[0].name, "default");
	memset(&strategy->directives[0].occasion, 0, sizeof(tss_occasion_t));
	for (i = 0; i < TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY+1; i++) {
		int g, n;
		char groupUsed[16];

		n = 0;
		for (g = 0; g < MAX_GROUPS; g++) {
			n += strategy->directives[i].instr.division.group[g].minTotalMembers;
		}
		if (n < 0 || n > 100) {
			for (g = 0; g < MAX_GROUPS; g++) {
				strategy->directives[i].instr.division.group[g].minTotalMembers = 0;
			}
		}
		else {
			strategy->directives[i].instr.division.unassignedPlayers = 100 - n;
		}

		memset(groupUsed, 0, sizeof(groupUsed));
		for (g = 0; g < MAX_GROUPS; g++) {
			n = strategy->directives[i].instr.groupOrganization[g];
			if (n < 0) break;
			if (n >= MAX_GROUPS) break;
			if (groupUsed[n]) break;

			groupUsed[n] = qtrue;
		}
		if (g < MAX_GROUPS) {
			for (g = 0; g < MAX_GROUPS; g++) {
				strategy->directives[i].instr.groupOrganization[g] = g;
			}
		}
	}

	ok = qtrue;

	Exit:
	if (f) trap_FS_FCloseFile(f);
	return ok;
}
#endif

#if !TSSINCVAR
qboolean CG_TSS_SaveStrategy(const char* filename, const tss_strategy_t* strategy) {
	fileHandle_t f;
	int i;

	strategyFileBufPos = (unsigned char*) &strategyFileBuf;

	memcpy(strategyFileBufPos, "HUNT", 4);
	strategyFileBufPos += 4;
	CG_TSS_PutInt(strategy->version);
	CG_TSS_PutInt(strategy->gametype);
	CG_TSS_PutString(strategy->generic, sizeof(strategy->generic));
	CG_TSS_PutString(strategy->name, sizeof(strategy->name));
	CG_TSS_PutString(strategy->comment, sizeof(strategy->comment));
	CG_TSS_PutInt(strategy->autoCondition);
	CG_TSS_PutInt(strategy->rfa_dangerLimit);
	CG_TSS_PutInt(strategy->rfd_dangerLimit);
	CG_TSS_PutInt(strategy->short_term);
	CG_TSS_PutInt(strategy->medium_term);
	CG_TSS_PutInt(strategy->long_term);

	for (i = 0; i < TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY+1; i++) {
		CG_TSS_PutDirective(&strategy->directives[i]);
	}



	trap_FS_FOpenFile(filename, &f, FS_WRITE);
	if (!f) {
		CG_Printf(S_COLOR_RED "could not write to %s\n", filename);
		return qfalse;
	}
	trap_FS_Write(&strategyFileBuf, sizeof(strategyFileBuf), f);
	trap_FS_FCloseFile(f);

	return qtrue;
}
#endif

void CG_TSS_InitStrategy(tss_strategy_t* strategy) {
	int d;

	memset(strategy, 0, sizeof(tss_strategy_t));

	memcpy(strategy->id, "HUNT", 4);
	strategy->version = TSS_STRATEGY_VERSION;
	strategy->gametype = cg.tssGametype;
	strcpy(strategy->generic, "Amiga 4ever!");

	strategy->rfa_dangerLimit = 0;
	strategy->rfd_dangerLimit = 25;

	strategy->short_term = 10;
	strategy->medium_term = 25;
	strategy->long_term = 75;

	for (d = 0; d < TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY+1; d++) {
		int gr;

		strategy->directives[d].instr.division.unassignedPlayers = 100;

		for (gr = 0; gr < MAX_GROUPS; gr++) {
			strategy->directives[d].instr.groupOrganization[gr] = gr;
			strategy->directives[d].instr.division.group[gr].minReadyMembers = 100;
			strategy->directives[d].instr.orders.order[gr].maxDanger = 25;
		}
	}
	strategy->directives[0].inUse = qtrue;
	strcpy(strategy->directives[0].name, "default");
}

static unsigned char stdChar[256] =
	"                                "
	" !!=S//!!!!.=.//0123456789//!=!!"
	"AABCDEFGHIJKLMNOPQRSTUVWXYZ!/!! "
	"!ABCDEFGHIJKLMNOPQRSTUVWXYZ!/!! "
	"E!!!!!!!!/S!O!!!!!!!!.===TS!O  Y"
	" !CL!Y/!!CA!=!R!0!23!MP.!10!123!"
	"AAAAAAACEEEEIIIIDNOOOOOXOUUUUYPS"
	"AAAAAAACEEEEIIIIDNOOOOO=OUUUUYPY"
;

static int TSS_StdChar(int c) {
	return stdChar[c & 255];
}

static int TSS_CompareChars(int c1, int c2) {
	if (c1 == c2) return 0;

	c1 = TSS_StdChar(c1);
	c2 = TSS_StdChar(c2);
	return c1 - c2;
}

static int TSS_CompareNames(const char* name1, const char* name2) {
	if (!name1 || !name2) {
		if (name1) return 1;	// NULL sorts lowest
		if (name2) return -1;	// NULL sorts lowest
		return 0;
	}

	while (*name1 && *name2) {
		int cmp;

		cmp = TSS_CompareChars(*name1, *name2);
		if (cmp) return cmp;

		name1++;
		name2++;
	}
	return (*name1 & 255) - (*name2 & 255);
}

static int CG_TSS_CompareStrategies(
	tss_strategySlot_t* s1,
	tss_strategySlot_t* s2,
	tss_strategySortOrder_t order
) {
	int cmp;

	// NOTE: strategies with highest creation / access time / search compatibility sort first
	switch (order) {
	case SSO_creationTime:
		cmp = s2->creationTime - s1->creationTime;
		if (cmp) return cmp;
		break;
	case SSO_accessTime:
		cmp = s2->accessTime - s1->accessTime;
		if (cmp) return cmp;
		break;
	case SSO_name_creationTime:
		cmp = TSS_CompareNames(s1->tssname, s2->tssname);
		if (cmp) return cmp;
		cmp = s2->creationTime - s1->creationTime;
		if (cmp) return cmp;
		break;
	case SSO_name_accessTime:
		cmp = TSS_CompareNames(s1->tssname, s2->tssname);
		if (cmp) return cmp;
		cmp = s2->accessTime - s1->accessTime;
		if (cmp) return cmp;
		break;
	case SSO_searchResult:
		cmp = searchCompatibility[s2->id] - searchCompatibility[s1->id];
		if (cmp) return cmp;
		cmp = TSS_CompareNames(s1->tssname, s2->tssname);
		if (cmp) return cmp;
		cmp = s2->accessTime - s1->accessTime;
		if (cmp) return cmp;
		break;
	default:
		break;
	}
	// this point should not be reached
	return s2->id - s1->id;
}

static int CG_TSS_InsertStrategy(tss_strategySlot_t* slot, tss_strategySortOrder_t order) {
	int i;
	int j;

	for (i = 0; i < numStrategies[order]; i++) {
		tss_strategySlot_t* cmp;

		cmp = &strategyStock.slots[sortedStrategies[order][i]];
		if (CG_TSS_CompareStrategies(cmp, slot, order) >= 0) break;
	}

	// insert at 'i'
	for (j = numStrategies[order] - 1; j >= i; j--) {
		// copy from 'j' to 'j+1'
		sortedStrategies[order][j + 1] = sortedStrategies[order][j];
	}
	sortedStrategies[order][i] = slot->id;
	numStrategies[order]++;
	return i;
}

static void CG_TSS_RemoveStrategy(tss_strategySlot_t* slot, tss_strategySortOrder_t order) {
	int i;
	int j;

	for (i = 0; i < numStrategies[order]; i++) {
		if (sortedStrategies[order][i] == slot->id) break;
	}
	if (i >= numStrategies[order]) return;

	for (j = i + 1; j < numStrategies[order]; j++) {
		// copy from 'j' to 'j-1'
		sortedStrategies[order][j - 1] = sortedStrategies[order][j];
	}
	sortedStrategies[order][j - 1] = -1;
	numStrategies[order]--;
}

static void CG_TSS_StartInitStrategyStock(void) {
	int i;

	memset(&strategyStock, 0, sizeof(strategyStock));
	memset(&sortedStrategies, -1, sizeof(sortedStrategies));
	memset(&searchCompatibility, 0, sizeof(searchCompatibility));
	searchPattern[0] = 0;
	cg.tssCreationClock = 1;
	cg.tssAccessClock = 1;
	for (i = 0; i < SSO_num_orders; i++) numStrategies[i] = 0;
	memset(strategyPaletteBufUsed, 0, sizeof(strategyPaletteBufUsed));
}

static void CG_TSS_EndInitStrategyStock(void) {
	int i;

	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		strategyStock.slots[i].id = i;
		strategyStock.slots[i].flags = 0;

		if (strategyStock.slots[i].filename[0]) {
			if (strategyStock.slots[i].creationTime >= cg.tssCreationClock) {
				cg.tssCreationClock = strategyStock.slots[i].creationTime + 1;
			}
			if (strategyStock.slots[i].accessTime >= cg.tssAccessClock) {
				cg.tssAccessClock = strategyStock.slots[i].accessTime + 1;
			}

			CG_TSS_InsertStrategy(&strategyStock.slots[i], SSO_creationTime);
			CG_TSS_InsertStrategy(&strategyStock.slots[i], SSO_accessTime);
			CG_TSS_InsertStrategy(&strategyStock.slots[i], SSO_name_creationTime);
			CG_TSS_InsertStrategy(&strategyStock.slots[i], SSO_name_accessTime);
			CG_TSS_InsertStrategy(&strategyStock.slots[i], SSO_searchResult);
		}
	}
}

#if TSSINCVAR
static qboolean TSSFS_EnterStrategyFileInStock(int cvarindex) {
	char cvarbase[32];
	char filename[TSS_NAME_SIZE];
	tss_packedStrategyHeader_t header;
	int i;
	tss_strategySlot_t* freeSlot;

	if (cvarindex < 0 || cvarindex > TSS_MAX_STRATEGIES) return qfalse;
	Com_sprintf(cvarbase, sizeof(cvarbase), "tsspak%03d", cvarindex);
	trap_Cvar_VariableStringBuffer(va("%sn", cvarbase), filename, sizeof(filename));
	if (!filename[0]) return qfalse;
	if (!TSSFS_GetPackedStrategyHeader(cvarbase, &header)) return qfalse;
	if (header.gametype != cg.tssGametype) return qtrue;
	
	freeSlot = NULL;
	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		tss_strategySlot_t* slot;

		slot = &strategyStock.slots[i];
		if (!slot->filename[0]) {
			if (!freeSlot) freeSlot = slot;
			continue;
		}
		if (strcmp(slot->filename, filename)) continue;

		freeSlot = slot;
		break;
	}
	if (!freeSlot) return qfalse;

	freeSlot->id = i;	// mark as valid
	Q_strncpyz(freeSlot->filename, filename, sizeof(freeSlot->filename));
	Q_strncpyz(freeSlot->tssname, header.name, sizeof(freeSlot->tssname));
	Q_strncpyz(freeSlot->cvarbase, cvarbase, sizeof(freeSlot->cvarbase));
	return qtrue;
}
#endif

#if TSSINCVAR
void TSSFS_LoadStrategyStock(void) {
	static tss_packedStrategyStock_t pss;
	int size;
	const char* stockName;
	int i;

	CG_TSS_StartInitStrategyStock();

	switch (cg.tssGametype) {
	case GT_TEAM:
		stockName = "tdmstk";
		break;
	case GT_CTF:
		stockName = "ctfstk";
		break;
	default:
		return;
	}

	size = TSSFS_CollectCVarData(stockName, &pss, sizeof(pss));
	if (size < sizeof(pss)) {
		memset(&pss, 0, sizeof(pss));
	}

	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		strategyStock.slots[i].id = -1;	// this is later used to detect deleted files
		strategyStock.slots[i].creationTime = pss.slots[i].creationTime;
		strategyStock.slots[i].accessTime = pss.slots[i].accessTime;
		Q_strncpyz(strategyStock.slots[i].filename, pss.slots[i].filename, sizeof(strategyStock.slots[i].filename));
	}

	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		if (!TSSFS_EnterStrategyFileInStock(i)) break;
	}

	// remove deleted files
	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		if (
			!strategyStock.slots[i].filename[0] ||
			strategyStock.slots[i].id < 0
		) {
			memset(&strategyStock.slots[i], 0, sizeof(tss_strategySlot_t));
		}

		strategyStock.slots[i].id = i;
	}

	// get system time
	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		if (strategyStock.slots[i].creationTime >= cg.tssCreationClock) {
			cg.tssCreationClock = strategyStock.slots[i].creationTime + 1;
		}
	}

	// set creation time on new files
	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		if (!strategyStock.slots[i].filename[0]) continue;
		if (strategyStock.slots[i].creationTime) continue;

		strategyStock.slots[i].creationTime = cg.tssCreationClock++;
	}
	
	CG_TSS_EndInitStrategyStock();

	if (size >= sizeof(pss)) {
		TSS_SetPalette(&pss.palette);
	}
}
#endif

#if TSSINCVAR
void TSSFS_SaveStrategyStock(void) {
	static tss_packedStrategyStock_t pss;
	const char* stockName;
	const char* stockFileName;
	const char* stockBase;
	int i;
	
	switch (cg.tssGametype) {
	case GT_TEAM:
		stockName = "tdmstk";
		stockFileName = "tss/tdm.stk";
		stockBase = "set tdmstk";
		break;
	case GT_CTF:
		stockName = "ctfstk";
		stockFileName = "tss/ctf.stk";
		stockBase = "set ctfstk";
		break;
	default:
		return;
	}

	memset(&pss, 0, sizeof(pss));
	TSS_GetPalette(&pss.palette);

	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		tss_strategySlot_t* slot;
		tss_packedStrategySlot_t* ps;

		slot = &strategyStock.slots[i];
		ps = &pss.slots[i];
		ps->creationTime = slot->creationTime;
		ps->accessTime = slot->accessTime;
		Q_strncpyz(ps->filename, slot->filename, sizeof(ps->filename));

		if (!ps->filename[0]) continue;
		if (!(slot->flags & STSL_nameChanged_F)) continue;

		slot->flags = 0;
		TSSFS_LoadStrategy(slot->cvarbase, &strategyFileBuf);
		Q_strncpyz(strategyFileBuf.name, slot->tssname, sizeof(strategyFileBuf.name));
		TSSFS_SaveStrategy(slot->filename, slot->cvarbase, &strategyFileBuf);
	}

	TSSFS_DumpBufferToCvars(stockName, &pss, sizeof(pss));
	TSSFS_DumpBufferToFile(stockFileName, stockBase, &pss, sizeof(pss));
}
#endif

#if !TSSINCVAR
void CG_TSS_LoadStrategyStock(void) {
	fileHandle_t f;
	int len;
	const char* stockFile;
	int i;

	CG_TSS_StartInitStrategyStock();

	// read the strategy stock
	// NOTE: the stock file has already been updated by UI_TSS_UpdateStrategyStock()
	switch (cg.tssGametype) {
	case GT_TEAM:
		strategyStockPath = "tss/tdm/";
		stockFile = "tss/tdm/" TSS_STOCK_FILE;
		break;
	case GT_CTF:
		strategyStockPath = "tss/ctf/";
		stockFile = "tss/ctf/" TSS_STOCK_FILE;
		break;
	default:
		strategyStockPath = NULL;
		return;
	}
	len = trap_FS_FOpenFile(stockFile, &f, FS_READ);
	if (f && len == sizeof(strategyStock)) {
		CG_Printf("reading %s...\n", stockFile);
		trap_FS_Read(&strategyStock, sizeof(strategyStock), f);
	}
	if (f) trap_FS_FCloseFile(f);

	CG_TSS_EndInitStrategyStock();
}
#endif

#if !TSSINCVAR
void CG_TSS_SaveStrategyStock(void) {
	char filename[64];
	fileHandle_t f;
	int len;
	int i;

	if (!strategyStockPath) return;

	// save the new tssnames in the affiliated strategy files
	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		if (!strategyStock.slots[i].filename[0]) continue;
		if (!(strategyStock.slots[i].flags & STSL_nameChanged_F)) continue;

		strategyStock.slots[i].flags = 0;
		
		// load the complete strategy file
		Com_sprintf(filename, sizeof(filename), "%s%s", strategyStockPath, strategyStock.slots[i].filename);
		len = trap_FS_FOpenFile(filename, &f, FS_READ);
		if (!f) goto NextSlot;
		if (len != sizeof(strategyFileBuf)) goto NextSlot;
		trap_FS_Read(&strategyFileBuf, sizeof(strategyFileBuf), f);
		trap_FS_FCloseFile(f);
		f = 0;

		// change the name & save back
		strcpy(strategyFileBuf.name, strategyStock.slots[i].tssname);	// only strings can be set directly in the file buf
		trap_FS_FOpenFile(filename, &f, FS_WRITE);
		if (!f) goto NextSlot;
		trap_FS_Write(&strategyFileBuf, sizeof(strategyFileBuf), f);
		trap_FS_FCloseFile(f);

		NextSlot:
		if (f) trap_FS_FCloseFile(f);
	}

	// save the strategy stock
	Com_sprintf(filename, sizeof(filename), "%s" TSS_STOCK_FILE, strategyStockPath);
	trap_FS_FOpenFile(filename, &f, FS_WRITE);
	if (f) {
		trap_FS_Write(&strategyStock, sizeof(strategyStock), f);
		trap_FS_FCloseFile(f);
	}
}
#endif

int CG_TSS_NumStrategiesInStock(tss_strategySortOrder_t order) {
	return numStrategies[order];
}

tss_strategySlot_t* CG_TSS_GetSlotByID(int id) {
	tss_strategySlot_t* slot;

	if (id < 0) return NULL;
	if (id >= TSS_MAX_STRATEGIES) return NULL;

	slot = &strategyStock.slots[id];
	if (!slot->filename[0]) return NULL;

	return slot;
}

tss_strategySlot_t* CG_TSS_GetSlotByName(const char* name) {
	int id;

	for (id = 0; id < TSS_MAX_STRATEGIES; id++) {
		tss_strategySlot_t* slot;

		slot = &strategyStock.slots[id];
		if (!slot->filename[0]) continue;

		if (TSS_CompareNames(slot->tssname, name)) continue;

		return slot;
	}

	return NULL;
}

tss_strategySlot_t* CG_TSS_GetSortedSlot(int sortIndex, tss_strategySortOrder_t order) {
	if (sortIndex < 0) return NULL;
	if (sortIndex >= numStrategies[order]) return NULL;

	return CG_TSS_GetSlotByID(sortedStrategies[order][sortIndex]);
}

int CG_TSS_GetSortIndexByID(int id, tss_strategySortOrder_t order) {
	int sortIndex;

	for (sortIndex = 0; sortIndex < numStrategies[order]; sortIndex++) {
		if (sortedStrategies[order][sortIndex] == id) return sortIndex;
	}
	return -1;
}

static int CG_TSS_GetStrategyBufHandle(void) {
	int i;

	for (i = 0; i < TSS_MAX_STRATEGIES_PER_PALETTE; i++) {
		if (strategyPaletteBufUsed[i]) continue;

		return i;
	}
	return -1;
}

qboolean CG_TSS_LoadPaletteSlot(tss_strategySlot_t* sslot, tss_strategyPaletteSlot_t* pslot) {
	int h;

	pslot->slot = sslot;
	pslot->isChanged = qfalse;
	pslot->strategy = NULL;	// mark as invalid
	pslot->strategyBufHandle = -1;

	h = CG_TSS_GetStrategyBufHandle();
	if (h < 0) return qfalse;

	// load the strategy file
	#if !TSSINCVAR
	{
		char filename[64];

		Com_sprintf(filename, sizeof(filename), "%s%s", strategyStockPath, sslot->filename);
		if (!CG_TSS_LoadStrategy(filename, &strategyPaletteBuf[h])) return qfalse;
	}
	#else
		if (!TSSFS_LoadStrategy(sslot->cvarbase, &strategyPaletteBuf[h])) return qfalse;
	#endif
	sslot->accessTime = cg.tssAccessClock++;
	cg.tssSavingNeeded = qtrue;	// the accessTime needs to be updated

	CG_TSS_RemoveStrategy(sslot, SSO_accessTime);
	CG_TSS_InsertStrategy(sslot, SSO_accessTime);

	CG_TSS_RemoveStrategy(sslot, SSO_name_accessTime);
	CG_TSS_InsertStrategy(sslot, SSO_name_accessTime);

	strategyPaletteBufUsed[h] = qtrue;

	// mark the palette entry as valid
	pslot->strategy = &strategyPaletteBuf[h];
	pslot->strategyBufHandle = h;
	return qtrue;
}

void CG_TSS_SavePaletteSlotIfNeeded(tss_strategyPaletteSlot_t* pslot) {
	if (!pslot->strategy || !pslot->slot) return;

	if (pslot->isChanged) {
		strcpy(pslot->strategy->name, pslot->slot->tssname);
		pslot->slot->flags &= ~STSL_nameChanged_F;

		#if !TSSINCVAR
		{
			char filename[64];

			Com_sprintf(filename, sizeof(filename), "%s%s", strategyStockPath, pslot->slot->filename);
			CG_TSS_SaveStrategy(filename, pslot->strategy);
		}
		#else
			TSSFS_SaveStrategy(pslot->slot->filename, pslot->slot->cvarbase, pslot->strategy);
		#endif
		pslot->isChanged = qfalse;
	}
}

void CG_TSS_FreePaletteSlot(tss_strategyPaletteSlot_t* pslot) {
	if (!pslot->strategy || !pslot->slot) return;

	CG_TSS_SavePaletteSlotIfNeeded(pslot);

	pslot->strategy = NULL;

	// free the palette buf
	if (
		pslot->strategyBufHandle >= 0 &&
		pslot->strategyBufHandle < TSS_MAX_STRATEGIES_PER_PALETTE
	) {
		strategyPaletteBufUsed[pslot->strategyBufHandle] = qfalse;
	}
}

static void CG_TSS_InitStrategySlot(tss_strategySlot_t* slot) {
	int i;
	char buf[TSS_NAME_SIZE];
	int ext;

	memset(slot, 0, sizeof(tss_strategySlot_t));

	ext = 0;
	do {
		Com_sprintf(
			buf, sizeof(buf),
			cg.tssGametype == GT_CTF? "ctf%03d.tss" : "tdm%03d.tss",
			ext
		);
		for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
			tss_strategySlot_t* cmp;

			cmp = &strategyStock.slots[i];
			if (cmp == slot) continue;
			if (Q_stricmp(cmp->filename, buf)) continue;

			ext++;
			break;
		}
		if (i >= TSS_MAX_STRATEGIES) {
			strcpy(slot->filename, buf);
			return;
		}
	} while (1);
}

static int CG_TSS_GetStrategySlotHandle(void) {
	int i;

	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
		if (strategyStock.slots[i].filename[0]) continue;

		return i;
	}
	return -1;
}

qboolean CG_TSS_CreateNewStrategy(tss_strategyPaletteSlot_t* pslot) {
	int bh;
	tss_strategy_t* strategy;
	int sh;
	tss_strategySlot_t* sslot;

	memset(pslot, 0, sizeof(*pslot));
	pslot->strategyBufHandle = -1;

	bh = CG_TSS_GetStrategyBufHandle();
	if (bh < 0) return qfalse;
	strategy = &strategyPaletteBuf[bh];

	sh = CG_TSS_GetStrategySlotHandle();
	if (sh < 0) return qfalse;
	sslot = &strategyStock.slots[sh];

	strategyPaletteBufUsed[bh] = qtrue;
	CG_TSS_InitStrategy(strategy);

	CG_TSS_InitStrategySlot(sslot);	
	sslot->id = sh;
	sslot->creationTime = cg.tssCreationClock++;
	sslot->accessTime = cg.tssAccessClock++;
	strcpy(sslot->tssname, strategy->name);

	CG_TSS_InsertStrategy(sslot, SSO_creationTime);
	CG_TSS_InsertStrategy(sslot, SSO_accessTime);
	CG_TSS_InsertStrategy(sslot, SSO_name_creationTime);
	CG_TSS_InsertStrategy(sslot, SSO_name_accessTime);
	CG_TSS_InsertStrategy(sslot, SSO_searchResult);

	pslot->isChanged = qtrue;
	pslot->slot = sslot;
	pslot->strategy = strategy;
	pslot->strategyBufHandle = bh;

	cg.tssSavingNeeded = qtrue;
	return qtrue;
}

static int TSS_EqualPrefixSize(const char* name, const char* searchstr, int* size) {
	int n;

	n = 0;
	*size = 0;
	while (*name && *searchstr) {
		if (*name == *searchstr) n++;
		else if (TSS_CompareChars(*name, *searchstr)) return n;

		name++;
		searchstr++;
		n++;
		(*size)++;
	}
	return n;
}

static int TSS_FindMaxSubstring(
	const char* name, int nameSize, const char* searchstr, int searchSize,
	int* matchSize
) {
	int maxSubstring;

	maxSubstring = 0;
	*matchSize = 0;
	while (nameSize > 0) {
		int size, mSize;

		size = TSS_EqualPrefixSize(name, searchstr, &mSize);
		if (size > maxSubstring) {
			maxSubstring = size;
			*matchSize = mSize;
		}

		name++;
		nameSize--;
		if (maxSubstring >= nameSize) break;
	}

	return maxSubstring;
}

static int TSS_SearchCompatibility(const char* name, const char* searchstr) {
	int sumComp;
	int nameSize;
	int searchSize;

	nameSize = strlen(name);
	searchSize = strlen(searchstr);

	sumComp = 0;
	while (searchSize > 0) {
		int comp;
		int matchSize;

		comp = TSS_FindMaxSubstring(name, nameSize, searchstr, searchSize, &matchSize);
		if (comp > 30) comp = 30;
		if (comp > 0) sumComp += 1 << comp;
		
		if (matchSize > 0) {
			searchstr += matchSize;
			searchSize -= matchSize;
		}
		else {
			searchstr++;
			searchSize--;
		}
	}
	return sumComp;
}

void CG_TSS_SetSearchPattern(const char* pattern) {
	int id;

	strcpy(searchPattern, pattern);
	numStrategies[SSO_searchResult] = 0;

	for (id = 0; id < TSS_MAX_STRATEGIES; id++) {
		if (!strategyStock.slots[id].filename[0]) continue;

		searchCompatibility[id] = TSS_SearchCompatibility(strategyStock.slots[id].tssname, pattern);
		CG_TSS_InsertStrategy(&strategyStock.slots[id], SSO_searchResult);
	}
}

int CG_TSS_StrategyNameChanged(int sortIndex, tss_strategySortOrder_t order) {
	tss_strategySlot_t* slot;
	int newIndex;

	slot = CG_TSS_GetSortedSlot(sortIndex, order);
	if (!slot) return sortIndex;

	slot->flags |= STSL_nameChanged_F;
	cg.tssSavingNeeded = qtrue;

	CG_TSS_RemoveStrategy(slot, SSO_name_creationTime);
	newIndex = CG_TSS_InsertStrategy(slot, SSO_name_creationTime);
	if (order == SSO_name_creationTime) sortIndex = newIndex;

	CG_TSS_RemoveStrategy(slot, SSO_name_accessTime);
	newIndex = CG_TSS_InsertStrategy(slot, SSO_name_accessTime);
	if (order == SSO_name_accessTime) sortIndex = newIndex;

	searchCompatibility[slot->id] = TSS_SearchCompatibility(slot->tssname, searchPattern);
	CG_TSS_RemoveStrategy(slot, SSO_searchResult);
	newIndex = CG_TSS_InsertStrategy(slot, SSO_searchResult);
	if (order == SSO_searchResult) sortIndex = newIndex;

	return sortIndex;
}
